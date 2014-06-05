require 'test_helper'
require 'generators/brb_install/brb_install_generator'

class BrbInstallGeneratorTest < Rails::Generators::TestCase
  tests BrbInstallGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
