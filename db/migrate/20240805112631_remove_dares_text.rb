class RemoveDaresText < ActiveRecord::Migration[7.1]
  def change
    remove_column :dares, :text, :string
  end
end
