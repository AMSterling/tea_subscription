# app/models/subscription.rb
class Subscription < ApplicationRecord
  validates :title, :status, :frequency, presence: true
  validates :price, presence: true, numericality: true

  enum status: { active: 0, cancelled: 1 }
  enum frequency: { one_time: 0, weekly: 1, monthly: 2, quarterly: 3 }

  belongs_to :tea
  belongs_to :customer
end
