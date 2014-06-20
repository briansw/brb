require 'test_helper'
require 'generators_test_helper'
require 'generators/brb/install/install_generator'

class Brb::InstallGeneratorTest < Rails::Generators::TestCase
  include GeneratorsTestHelper
  tests Brb::InstallGenerator
  
  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator
  #   end
  # end
  # 
  # test "generator adds routes" do
  #   run_generator
  #   assert_file "app/uploaders/image_uploader.rb", /class ImageUploader < Admin::AttachmentUploader/
  # end
end
