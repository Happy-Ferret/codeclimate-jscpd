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
                        content: content,
                        location: {
                          path: @path,
                          lines: {
                            begin: @start,
                            end: @start + @lines
                          }
                        }
                       )
        end

        private

        def content
          <<-CONTENT.gsub(/^ {10}/, '')
          Duplicated code can lead to software that is hard to understand and difficult to change. The Don't Repeat Yourself (DRY) principle states:

          Every piece of knowledge must have a single, unambiguous, authoritative representation within a system.
          When you violate DRY, bugs and maintenance problems are sure to follow. Duplicated code has a tendency to both continue to replicate and also to diverge (leaving bugs as two similar implementations differ in subtle ways).

          #### Refactorings

          * [Extract Method](https://sourcemaking.com/refactoring/extract-method)
          * [Extract Class](https://sourcemaking.com/refactoring/extract-class)
          * [Form Template Method](https://sourcemaking.com/refactoring/form-template-method)
          * [Introduce Null Object](https://sourcemaking.com/refactoring/introduce-null-object)
          * [Pull Up Method](https://sourcemaking.com/refactoring/pull-up-method)
          * [Pull Up Field](https://sourcemaking.com/refactoring/pull-up-field)
          * [Substitute Algorithm](https://sourcemaking.com/refactoring/substitute-algorithm)

          #### Further Reading

          * [Don't Repeat Yourself](http://c2.com/cgi/wiki?DontRepeatYourself) on the C2 Wiki
          * [Duplicated Code on SourceMaking](https://sourcemaking.com/refactoring/smells/duplicate-code)
          * ["Refactoring: Improving the Design of Existing Code"](http://www.amazon.com/gp/product/0201485672/), Duplicated Code, p76 - Martin Fowler et. al.
          CONTENT
        end
      end
    end
  end
end
