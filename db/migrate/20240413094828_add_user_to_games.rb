# frozen_string_literal: true

class AddUserToGames < ActiveRecord::Migration[7.1]
  def change
    add_reference :games, :user, null: false, foreign_key: true # rubocop:disable Rails/NotNullColumn
  end
end
