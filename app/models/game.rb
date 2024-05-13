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
    players_ids = players.order(:id).pluck(:id)
    return if players.empty?
    current_index = players_ids.find { |id| id == current_player_id }
    current_index = Player.find_by(id: current_index).nil? ? 0 : current_index # current_index = 0 if current_player is nil 
    next_index = (current_index + 1) % players_ids.count # if last ==> first 
    next_player_id = players_ids[next_index]

    update(current_player_id: next_player_id)
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
