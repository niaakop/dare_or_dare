class Game < ApplicationRecord
  belongs_to :user  
  has_many :players
  serialize :used_dare_ids, Array, coder: YAML
  after_create :set_initial_player
  after_create :select_dare

  def current_player
    Player.find_by(id: current_player_id)
  end

  def set_initial_player
    update(current_player_id: players.first.id) if current_player_id.nil? && players.any?
  end

  def selected_dare
    Dare.find_by(id: selected_dare_id)
  end

  def select_next_player
    game_players = self.players
    # players_ids = players.pluck(:id)
    return if game_players.empty?  
    current_index = game_players.find_index { |player| player.id == current_player_id }
    current_index = current_index.nil? ? 0 : current_index 
    next_index = (current_index + 1) % game_players.count
    next_player_id = game_players[next_index].id

    update(current_player_id: next_player_id)
    select_dare
  end

  def select_dare
    self.selected_dare_id = available_dares_ids.sample
    self.used_dare_ids.push(selected_dare_id) unless selected_dare_id.nil?
    save
  end

  def available_dares_ids
    @available_dares_ids = Dare.pluck(:id).to_a - used_dare_ids.to_a  
  end

  def update_available_dares_ids
    @available_dares_ids = Dare.pluck(:id).to_a
    self.used_dare_ids = []
    save
  end

  private

  def set_initial_player
    update(current_player_id: players.first.id) if players.any? && current_player_id.nil?
  end
end
