require 'spec_helper'

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

describe Concerns::CRUDTable do
  
  it "adds headings" do
    CRUDDummy.has_heading 'Name'
    expect(CRUDDummy.crud_headings).not_to be_empty
  end
  
  it "stores heading shit" do
    CRUDDummy.has_heading 'Name', link: :last_name, display: :name, default: true
    heading = CRUDDummy.crud_headings.first
    expect(heading.title).to eq('Name')
  end
  
end

describe Concerns::CRUDTable::Heading do
  
  it "stores label" do
    heading = Concerns::CRUDTable::Heading.new 'Name', link: :last_name, display: :name, default: true
    expect(heading.title).not_to be_nil
  end
  
  it "stores link" do
    heading = Concerns::CRUDTable::Heading.new 'Name', link: :last_name, display: :name, default: true
    expect(heading.link).not_to be_nil
  end
  
  it "stores default" do
    heading = Concerns::CRUDTable::Heading.new 'Name', link: :last_name, display: :name, default: true
    expect(heading.default).not_to be_nil
  end
  
  it "stores display" do
    heading = Concerns::CRUDTable::Heading.new 'Name', link: :last_name, display: :name, default: true
    expect(heading.instance_variable_get(:@display)).not_to be_nil
  end
  
end