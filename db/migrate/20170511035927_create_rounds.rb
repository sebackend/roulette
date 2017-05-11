class CreateRounds < ActiveRecord::Migration[5.0]
  def change
    create_table :rounds do |t|
      t.string :result
      t.boolean :over_25_degrees

      t.timestamps
    end
  end
end
