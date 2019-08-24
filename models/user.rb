class User < ActiveRecord::Base
  has_secure_password
  has_many :offers
  has_many :items
  
  # validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: 'Invalid email format' }, uniqueness: true, presence: true
  # validates :username, presence: true, uniqueness: true
  # validates :password, length: { minimum: 8 }
  # validates :suburb, presence: true
  # validates :postcode, length: { is: 4 }
end