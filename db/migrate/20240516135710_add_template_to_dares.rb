# frozen_string_literal: true

class AddTemplateToDares < ActiveRecord::Migration[7.1]
  def change
    add_column :dares, :template, :string
  end
end
