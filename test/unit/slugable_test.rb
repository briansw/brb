require 'test_helper'

class SlugableTest < ActiveSupport::TestCase
  
  class NoMethods
    include Concerns::Slugable
  end

  class AddsMethods
    include Concerns::Slugable
    def self.before_save(*args); end
    def test
      'foo'
    end
  end
  
  test 'doesnt add methods when included' do
    assert !NoMethods.respond_to?(:from_param)
    assert !NoMethods.new.respond_to?(:generate_slug)
  end
  
  test 'adds methods when called' do
    AddsMethods.slugable :test
    assert AddsMethods.respond_to?(:from_param)
    assert AddsMethods.new.respond_to?(:generate_slug)
    assert_equal 'foo', AddsMethods.new.to_param
  end
  
end