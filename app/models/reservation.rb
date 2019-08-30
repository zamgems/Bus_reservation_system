class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :bus
  has_many :seats, :dependent => :destroy
  accepts_nested_attributes_for :seats
  enum status: { active:"active", inactive:"inactive"}
  scope :future_reservations, ->{where("date >= ? and status = ?",Time.now.to_date,"active")}
  scope :past_reservations, ->{where("date < ?",Time.now.to_date)}
  scope :search_by_date, ->(date){where('date like ?', date)}
end
