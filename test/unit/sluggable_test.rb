require 'test_helper'

class SluggableTest < ActiveSupport::TestCase
  
  class NoMethods
    include Concerns::Sluggable
  end

  class AddsMethods < NoMethods
    attr_accessor :some_attribute
    def self.before_save(*args); end
  end
  
  class SlugMethod < NoMethods
    attr_accessor :slug
    attr_accessor :some_attribute
    def self.before_save(*args); end
  end
  
  test 'doesnt add methods when included' do
    assert !NoMethods.respond_to?(:from_param)
    assert !NoMethods.new.respond_to?(:generate_slug)
  end
  
  test 'adds methods when called' do
    AddsMethods.sluggable :some_attribute
    assert AddsMethods.respond_to?(:from_param)
    assert AddsMethods.new.respond_to?(:generate_slug)
  end
  
  test 'returns slug from to_param' do
    SlugMethod.sluggable :some_attribute
    record = SlugMethod.new
    record.slug = 'foo'
    assert_equal 'foo', record.to_param
  end
  
end