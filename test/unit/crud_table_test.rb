require 'test_helper'

class CRUDDummy
  attr_accessor :name, :last_name
  
  def initialize
    @name = 'Jack'
    @last_name = 'Jennings'
  end
  
  def self.scope(*args, &block)
  end
  
  include Concerns::CRUDTable
end

class CRUDTableTest < ActiveSupport::TestCase
  
  teardown do
    CRUDDummy.crud_headings = []
  end
  
  test 'adds headings' do
    CRUDDummy.has_heading 'Name'
    assert_not_empty CRUDDummy.crud_headings
  end
  
  test 'stores heading configuration' do
    CRUDDummy.has_heading 'Name', link: :last_name, display: :name, default: true
    heading = CRUDDummy.crud_headings.first
    assert_equal 'Name', heading.title
  end
  
end

class CRUDTableHeadingTest < ActiveSupport::TestCase
  
  test "stores label" do
    heading = Concerns::CRUDTable::Heading.new 'Name', link: :last_name, helper: :name, default: true
    assert_not_nil heading.title
  end
  
  test "stores link" do
    heading = Concerns::CRUDTable::Heading.new 'Name', link: :last_name, helper: :name, default: true
    assert_not_nil heading.link
  end
  
  test "stores default" do
    heading = Concerns::CRUDTable::Heading.new 'Name', link: :last_name, helper: :name, default: true
    assert_not_nil heading.default
  end
  
  test "stores helper" do
    heading = Concerns::CRUDTable::Heading.new 'Name', link: :last_name, helper: :name, default: true
    assert_not_nil heading.instance_variable_get(:@helper)
  end
  
end
