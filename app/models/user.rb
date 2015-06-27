class User < ActiveRecord::Base
	has_many(:posts)
	validates :password, length: { minimum: 5, maximum: 72 }
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :name, presence: true, length: {minimum: 3, maximum: 72}
	validates :email, uniqueness: true

	has_secure_password
end
