class User < ActiveRecord::Base
  include Concerns::Adminable
  include Concerns::CRUDTable

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :email
  validates_uniqueness_of :email

  has_secure_password

  has_heading 'Name', link: 'last_name', display: :name, default: true
  has_heading 'Username', link: 'username'
  has_heading 'Email', link: 'email'
  has_heading 'Active', link: 'active'

  adminable position: 7

  def name
    "#{first_name} #{last_name}"
  end

  def self.per_page
    self.per_page = 10
  end

end
