# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Faker::Config.locale = 'fr'

def pick_city
  city = Faker::Address.city
  if City.find_by(name: city)
    pick_city
  end
  city
end

def pick_specialty
  specialty = Faker::Hobby.activity
  if Specialty.find_by(name: specialty)
    pick_specialty
  end
  specialty
end

# Remise à 0 de la DBB
City.destroy_all
Specialty.destroy_all
Doctor.destroy_all
Patient.destroy_all
JoinTableSpecialtyDoctor.destroy_all

# Création de villes et spécialités avec appel à des méthodes
# pour vérifier qu'elles sont bien toutes différentes
50.times do
  City.create(name: pick_city)
  Specialty.create(name: pick_specialty)
end

# Création de 100 patients et 100 docteurs avec chacun une spécialité au hasard
100.times do
  doctor = Doctor.create(
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name, 
    zip_code: Faker::Address.zip_code,
    city: City.all[rand(0..49)]
  )

  JoinTableSpecialtyDoctor.create(
    doctor: doctor,
    specialty: Specialty.all[rand(0..49)]
  )

  Patient.create(
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name,
    city: City.all[rand(0..49)]
  )
end

# Ajout de spécialités sur des docteurs au hasard pour que certains en aient plusieurs
50.times do
  JoinTableSpecialtyDoctor.create(
    doctor: Doctor.all[rand(0..99)],
    specialty: Specialty.all[rand(0.49)]
  )
end

# Création de 500 rdv
500.times do
  Appointment.create(
    date: Faker::Time.between(from: DateTime.new(2021, 10, 28, 9), to: DateTime.new(2022, 10, 28, 18)), 
    doctor: Doctor.all[rand(0..99)], 
    patient: Patient.all[rand(0..99)],
    city: City.all[rand(0..49)]
  )
end
