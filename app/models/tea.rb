class Tea < ApplicationRecord
  validates :title, :description, presence: true
  validates :temperature, :brew_time, presence: true, numericality: true

  has_many :subscriptions
  has_many :customers, through: :subscriptions
end
