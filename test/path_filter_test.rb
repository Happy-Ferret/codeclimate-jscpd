require 'minitest_helper'

require 'cc/engine/jscpd/path_filter'

module CC
  module Engine
    module Jscpd
      class PathFilterTest < Minitest::Test
        describe 'PathFilter' do
          describe 'call' do
            it 'only keeps directories' do
              af = PathFilter.new(['file.rb', 'file.coffee', 'folder/'])
              assert_equal ['folder/'], af.call
            end
          end
        end
      end
    end
  end
end
