class Owner < ApplicationRecord
  belongs_to :user
  has_many :buses, :dependent => :destroy
end
