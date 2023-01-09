# app/models/customer.rb
class Customer < ApplicationRecord
  validates :first_name, :last_name, :address, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Must be valid email address' }

  has_many :subscriptions
  has_many :teas, through: :subscriptions
end
