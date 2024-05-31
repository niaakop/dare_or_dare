# frozen_string_literal: true

class AddUsedDareIdsToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :used_dare_ids, :text
  end
end
