require 'test_helper'
require 'generators/brb_model/brb_model_generator'

class BrbModelGeneratorTest < Rails::Generators::TestCase
  tests BrbModelGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
