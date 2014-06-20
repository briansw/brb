require 'test_helper'
require 'generators_test_helper'
require 'generators/brb/scaffold/scaffold_generator'

class Brb::ScaffoldGeneratorTest < Rails::Generators::TestCase
  include GeneratorsTestHelper
  tests Brb::ScaffoldGenerator
  arguments %w(duck)
  
  setup :copy_routes
  
  test "generator runs without errors" do
    assert_nothing_raised do
      run_generator
    end
  end
  
  test "generator adds routes" do
    run_generator
    assert_file "config/routes.rb" do |route|
      assert_match(/admin_for :ducks$/, route)
    end
  end
end
