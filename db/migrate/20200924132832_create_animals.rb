class CreateAnimals < ActiveRecord::Migration[6.0]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :slug
      t.string :image
      t.date :date_of_birth
      t.boolean :adoption_status, null: false, default: false
      t.string :adopter_name, null: false, default: ''
      t.references :animal_kind, null: false, foreign_key: true

      t.timestamps
    end

    add_index :animals, :slug, unique: true
  end
end
