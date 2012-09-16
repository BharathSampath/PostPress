class User < ActiveRecord::Base
  has_one :role, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :postvotes, :dependent => :destroy
  has_many :commentvotes, :dependent => :destroy

  validates_uniqueness_of :email
  validates_length_of :pwd, :within => 5..40
  validates :first_name, :presence => true
  validates :last_name, :presence => true

end
