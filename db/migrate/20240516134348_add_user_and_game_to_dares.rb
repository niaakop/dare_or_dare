# frozen_string_literal: true

class AddUserAndGameToDares < ActiveRecord::Migration[7.1]
  def change
    add_reference :dares, :user, foreign_key: true
    add_reference :dares, :game, foreign_key: true
  end
end
