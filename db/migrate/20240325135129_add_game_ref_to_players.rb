class AddGameRefToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_reference :players, :game, foreign_key: true
  end
end
