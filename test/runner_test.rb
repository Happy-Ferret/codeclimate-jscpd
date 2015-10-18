require 'minitest_helper'
require 'mocha/mini_test'

require 'cc/engine/jscpd/runner'

module CC
  module Engine
    module Jscpd
      class RunnerTest < Minitest::Test
        describe 'Runner' do
          let(:mock_io) { mock }
          let(:output) { '{"duplicates":[{"lines":7,"tokens":85,"firstFile":{"start":100,"name":"app/features/designs/design_controller.coffee"},"secondFile":{"start":139,"name":"app/features/designs/design_controller.coffee"},"fragment":"  Design.findOne\n    name: req.params.name\n  , (err, design) -&gt;\n    return next(err) if err || !design || !(version = design.getVersion(req.params.version))\n    s3.list version.basePath(), (err, files) -&gt;\n      return next(err) if err\n\n      archive = archiver &#x27;tar&#x27;,"}],"statistics":{"clones":5,"duplications":83,"files":6,"percentage":"1.31","lines":6326}}' }

          describe 'call' do
            it 'raises when command fails' do
              Open3.expects(:popen3).returns([stub(gets: nil), stub(gets: nil), stub(gets: 'err')])

              assert_raises SystemExit do
                Runner.new(directory: 'foo', engine_config: { 'include_paths' => ['bar/'] }, io: mock_io).call
              end
            end
            it 'raises when output in Tempfile is empty' do
              Open3.expects(:popen3).returns([stub(gets: nil), stub(gets: nil), stub(gets: nil)])
              Tempfile.any_instance.expects(:read).returns('')

              assert_raises SystemExit do
                Runner.new(directory: 'foo', engine_config: { 'include_paths' => ['bar/'] }, io: mock_io).call
              end
            end
            it 'reports issue json to console' do
              Open3.expects(:popen3).returns([stub(gets: nil), stub(gets: nil), stub(gets: nil)])
              Tempfile.any_instance.expects(:read).returns(output)
              mock_io.expects(:puts)

              Runner.new(directory: 'foo', engine_config: { 'include_paths' => ['bar/'] }, io: mock_io).call
            end
            it 'invokes command for each directory' do
              Open3.expects(:popen3).times(2).returns([stub(gets: nil), stub(gets: nil), stub(gets: nil)])
              Tempfile.any_instance.expects(:read).times(2).returns(output)
              mock_io.expects(:puts).times(2)

              Runner.new(directory: 'foo', engine_config: { 'include_paths' => ['bar/', 'baz/'] }, io: mock_io).call
            end
          end
        end
      end
    end
  end
end
