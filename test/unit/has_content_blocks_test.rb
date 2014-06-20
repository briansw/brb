require 'test_helper'
require 'temping'

class HasContentBlocksTest < ActiveSupport::TestCase
  
  test 'does not have content blocks' do
    Temping.create :has_content_blocks_dummy_1 do
      include Concerns::HasContentBlocks
    end

    assert !HasContentBlocksDummy1.new.respond_to?(:content_blocks)
    assert !HasContentBlocksDummy1.new.respond_to?(:content_blocks_attributes=)
  end
  
  test 'content blocks associations are setup' do
    Temping.create :has_content_blocks_dummy_2 do
      include Concerns::HasContentBlocks
    end
    
    HasContentBlocksDummy2.has_content_block :foo
    assert HasContentBlocksDummy2.new.respond_to?(:content_blocks)
    assert HasContentBlocksDummy2.new.respond_to?(:content_blocks_attributes=)
  end
  
  test 'content blocks are setup' do
    Temping.create :has_content_blocks_dummy_3 do
      include Concerns::HasContentBlocks
    end
    
    HasContentBlocksDummy3.has_content_block :bar
    HasContentBlocksDummy3.has_content_block :baz
    
    assert HasContentBlocksDummy3.respond_to?(:available_content_blocks)
    assert_includes HasContentBlocksDummy3.available_content_blocks, 'Bar'
    assert_includes HasContentBlocksDummy3.available_content_blocks, 'Baz'
    
    HasContentBlocksDummy3.has_content_blocks :qaaz, :foo_bar
    assert_includes HasContentBlocksDummy3.available_content_blocks, 'Qaaz'
    assert_includes HasContentBlocksDummy3.available_content_blocks, 'FooBar'
  end
  
end
