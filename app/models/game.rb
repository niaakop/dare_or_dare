require 'pry' 
class Game < ApplicationRecord
  belongs_to :user  
  has_many :players
  after_create :update_selected_dare
  serialize :used_dare_ids, Array, coder: YAML

  def current_player
    Player.find_by(id: current_player_id)
  end

  def selected_dare
    Dare.find_by(id: selected_dare_id)
  end

  def select_next_player
    players_count = players.count
    current_index = players.find_index { |player| player.id == current_player_id }
    next_index = (current_index + 1) % players_count
    next_player_id = players[next_index].id
    update(current_player_id: next_player_id)
    update_selected_dare
  end

  def update_selected_dare
  @available_dare_ids = Dare.pluck(:id).to_set
  p "available_dare_ids #{@available_dare_ids}"
  p "used_dare_ids #{self.used_dare_ids}"
  
  self.used_dare_ids ||= [] # Ensure used_dare_ids is initialized as an empty array if it's nil
  
  # Add the selected dare ID to the used_dare_ids array
  self.used_dare_ids << selected_dare_id unless selected_dare_id.nil? 
  
  p "used_dare_ids #{self.used_dare_ids}"
  
  @available_dare_ids -= self.used_dare_ids.to_set.to_a
  
  p "available_dare_ids #{@available_dare_ids}"
  p "self.selected_dare_id #{self.selected_dare_id}"

  if @available_dare_ids.empty?
    self.used_dare_ids = [] # Reset used_dare_ids to an empty array
    p "available_dare_ids.empty!!!"
  else
    # Set selected_dare_id to a random available dare ID
    self.selected_dare_id = @available_dare_ids.to_a.sample
    p "self.selected_dare_id #{self.selected_dare_id}"
  end

  # Save the changes to the database
  save
end

end
