# frozen_string_literal: true

class CreateDares < ActiveRecord::Migration[7.1]
  def change
    create_table :dares do |t|
      t.string :text

      t.timestamps
    end
  end
end
