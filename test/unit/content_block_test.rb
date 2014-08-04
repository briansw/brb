require 'test_helper'

class ContentBlockTest < ActiveSupport::TestCase

  test "finds block types by file" do
    assert ContentBlock.block_list_from_files.any?
  end
  
  test "finds block types in nested folders" do
    flunk "write me"
  end

end
