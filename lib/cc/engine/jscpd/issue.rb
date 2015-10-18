require 'json'

module CC
  module Engine
    module Jscpd
      class Issue
        def initialize(path:, start:, lines:)
          @path = path
          @start = start
          @lines = lines
        end

        def to_json
          JSON.generate(type: 'issue',
                        check_name: 'Code duplication',
                        description: 'Duplicate code detected.',
                        categories: ['Duplication'],
                        location: {
                          path: @path,
                          lines: {
                            begin: @start,
                            end: @start + @lines
                          }
                        }
                       )
        end
      end
    end
  end
end
