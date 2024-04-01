class Game < ApplicationRecord
  # belongs_to :user
  has_many :players

  def current_player
    Player.find_by(id: current_player_id)
  end

  def select_next_player
    players_count = players.count
    current_index = players.find_index { |player| player.id == current_player_id }
    next_index = (current_index + 1) % players_count
    next_player_id = players[next_index].id
    update(current_player_id: next_player_id)
    update_selected_dare
  end

  private

  def update_selected_dare
    @dares = ["Dare 1", "Dare 2", "Dare 3", "Dare 4", "Dare 5"]
    self.selected_dare = @dares.sample
    save
  end
end
