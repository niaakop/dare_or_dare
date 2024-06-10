# frozen_string_literal: true

class Player < ApplicationRecord
  belongs_to :game
  before_destroy :adjust_game_current_player

  validates :name, presence: true
  validates :gender, presence: true

  enum gender: { female: 0, male: 1 }

  private

  def adjust_game_current_player
    game.select_next_player if game.current_player_id == id
  end
end
