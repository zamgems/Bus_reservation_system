class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :reservations, :dependent => :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { admin:'admin', customer:'customer', owner:'owner' }
  enum status: { approved:'approved', suspended:'suspended', pending:'pending' }
  ROLES = %w(customer owner)
end
