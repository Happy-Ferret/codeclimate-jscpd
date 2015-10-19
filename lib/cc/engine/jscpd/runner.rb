require 'json'
require 'open3'
require 'tempfile'
require 'cc/engine/jscpd/issue'
require 'cc/engine/jscpd/path_filter'

module CC
  module Engine
    module Jscpd
      class Runner
        def initialize(directory:, engine_config:{}, io:)
          @directory = directory
          @include_paths = engine_config['include_paths'] || []
          @min_tokens = engine_config['min_tokens'] || 70
          @min_lines = engine_config['min_lines'] || 5

          @io = io
        end

        def call
          paths = PathFilter.new(@include_paths).call
          paths.each do |path|
            run_command(path)
          end
        end

        private

        def run_command(path)
          output_file = Tempfile.new("jscpd-#{path.hash}")
          cmd = command(path, output_file)
          _stdin, _stdout, stderr = Open3.popen3(cmd, chdir: @directory)
          if (err = stderr.gets)
            abort "Jscpd command failed. Command: #{cmd} - Error: #{err}"
          else
            output = output_file.read
            return if output.empty?
            process_results(output)
          end
        ensure
          output_file.close!
        end

        def process_results(output)
          results = JSON.parse(output)
          results['duplicates'].each do |result|
            check_result(result)
          end
        end

        def check_result(result)
          lines = result['lines']
          start = result['firstFile']['start']
          path = result['firstFile']['name']
          issue = Issue.new(path: path, start: start, lines: lines)
          @io.puts "#{issue.to_json}\0"
        end

        def command(path, output_file)
          "jscpd --path #{path} --reporter json -o #{output_file.path} -t #{@min_tokens} -l #{@min_lines}"
        end
      end
    end
  end
end
