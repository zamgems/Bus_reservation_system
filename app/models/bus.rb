class Bus < ApplicationRecord
	extend FriendlyId
	friendly_id :name, use: [:slugged, :history]
	belongs_to :owner
	has_many :reservations, :dependent => :destroy
	
	validates :name, presence: true
	validates :registration_no, presence: true
	validates :source, presence: true
	validates :destination, presence: true
	validates :total_seats, presence: true
	validates :status, presence: true

	enum status: { available:"available", unavailable:"unavailable"}

	STATUSES = %w(available unavailable)

	scope :available_buses, ->(params){ where("status = 'available' and owner_id in ( select id from owners where user_id in (select id from users where status = 'approved' and role = 'owner' )) and source LIKE ? and destination LIKE ? and name LIKE ?", "%#{params[:source]}%", "%#{params[:destination]}%", "%#{params[:name]}%")  }
	scope :search_buses, ->(params){ where('source LIKE ? and destination LIKE ? and name LIKE ?', "%#{params[:source]}%", "%#{params[:destination]}%", "%#{params[:name]}%") }
end
