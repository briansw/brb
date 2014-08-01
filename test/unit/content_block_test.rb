require 'test_helper'

class ContentBlockTest < ActiveSupport::TestCase
  
  test "finds block types by file" do
    assert ContentBlock.block_list_from_files.any?
  end
  
  test "sets block types on class load" do
    assert ContentBlock.block_types.any?
  end
  
end
