class AddPrizeToBet < ActiveRecord::Migration[5.0]
  def change
    add_column :bets, :prize, :integer, null:false, default:0
  end
end
