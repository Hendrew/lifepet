class CreateAnimalKinds < ActiveRecord::Migration[6.0]
  def change
    create_table :animal_kinds do |t|
      t.string :kind
      t.string :slug

      t.timestamps
    end

    add_index :animal_kinds, :slug, unique: true
  end
end
