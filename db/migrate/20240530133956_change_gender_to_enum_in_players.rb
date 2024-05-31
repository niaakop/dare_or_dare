# frozen_string_literal: true

class ChangeGenderToEnumInPlayers < ActiveRecord::Migration[6.1]
  def up
    # Add the new integer column
    add_column :players, :gender_tmp, :integer

    # Update the new column with enum values based on the old string column
    Player.reset_column_information
    Player.find_each do |player|
      if player.gender.present?
        gender_value = player.gender.downcase
        player.update_columns(gender_tmp: Player.genders[gender_value]) # rubocop:disable Rails/SkipsModelValidations
      end
    end

    # Remove the old string column
    remove_column :players, :gender

    # Rename the new integer column to gender
    rename_column :players, :gender_tmp, :gender

    # Ensure gender is not null
    change_column_null :players, :gender, false
  end

  def down
    # Add the old string column back
    add_column :players, :gender_tmp, :string

    # Update the new string column with values based on the enum
    Player.reset_column_information
    Player.find_each do |player|
      if player.gender.present?
        player.update_columns(gender_tmp: player.gender.titleize) # rubocop:disable Rails/SkipsModelValidations
      end
    end

    # Remove the integer column
    remove_column :players, :gender

    # Rename the new string column to gender
    rename_column :players, :gender_tmp, :gender
  end
end
