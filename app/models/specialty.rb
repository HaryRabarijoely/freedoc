class Specialty < ApplicationRecord
  has_many :join_table_specialty_doctors, dependent: :destroy
  has_many :doctors, through: :join_table_specialty_doctors
end
