class RemoveSpecialtyFromDoctors < ActiveRecord::Migration[5.2]
  def change
    change_table :doctors do |t|
      t.remove :specialty
    end
  end
end
