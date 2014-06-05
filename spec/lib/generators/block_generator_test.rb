require 'test_helper'
require 'generators/block/block_generator'

class BlockGeneratorTest < Rails::Generators::TestCase
  tests BlockGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
