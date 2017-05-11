class CreateBets < ActiveRecord::Migration[5.0]
  def change
    create_table :bets do |t|
      t.references :player, foreign_key: true
      t.references :round, foreign_key: true
      t.integer :amount
      t.string :option

      t.timestamps
    end
  end
end
