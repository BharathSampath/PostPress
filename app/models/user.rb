class User < ActiveRecord::Base
  has_one :role
  has_many :posts
  has_many :comments
  has_many :postvotes
  has_many :commentvotes

  validates_uniqueness_of :email
  validates_length_of :pwd, :within => 5..40
  validates :first_name, :presence => true
  validates :last_name, :presence => true

end
