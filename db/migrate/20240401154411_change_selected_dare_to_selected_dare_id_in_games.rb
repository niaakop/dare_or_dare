class ChangeSelectedDareToSelectedDareIdInGames < ActiveRecord::Migration[7.1]
  def up
    rename_column :games, :selected_dare, :selected_dare_id
  end

  def down
    rename_column :games, :selected_dare_id, :selected_dare
  end
end
