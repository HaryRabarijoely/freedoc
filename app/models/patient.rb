class Patient < ApplicationRecord
  belongs_to :city
  has_many :appointments, dependent: :destroy
  has_many :doctors, through: :appointments
end
