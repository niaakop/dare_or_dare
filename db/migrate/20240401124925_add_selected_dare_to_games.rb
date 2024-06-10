# frozen_string_literal: true

class AddSelectedDareToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :selected_dare, :string
  end
end
