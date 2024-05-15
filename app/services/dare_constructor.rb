class DareConstructor
  def initialize(template, game)
    @template = template
    @game = game
    @players_ids = []
  end

  def construct_dare
    @players_ids = @game.players.pluck(:id)
    @players_ids.delete(current_player.id)
    dare = @template.dup
    dare.gsub!("{target}", current_player.name)
    dare = replace_players(dare, "{female}", female_players_ids)
    dare = replace_players(dare, "{male}", male_players_ids)
    dare = replace_players(dare, "{opposite}", opposite_gender_players_ids)
    dare = replace_players(dare, "{same}", same_gender_players_ids)
    dare = replace_players(dare, "{any}", @players_ids)
    dare
  end

  private

  def replace_players(dare, placeholder, player_ids)
    while dare.include?(placeholder) && player_ids.any?
      player_id = player_ids.sample
      player = Player.find(player_id)
      dare.sub!(placeholder, player.name)
      @players_ids.delete(player_id)
      player_ids.delete(player_id)
    end
    dare
  end

  def current_player
    @game.current_player
  end

  def same_gender_players_ids
    gender = current_player.gender
    @players_ids.select { |id| player = Player.find(id); player.gender == gender}
  end

  def opposite_gender_players_ids
    gender = current_player.gender
    @players_ids.select { |id| player = Player.find(id); player.gender != gender}
  end

  def female_players_ids
    @players_ids.select do |id| 
      player = Player.find(id)
      player.gender == 'Female'
    end
  end

  def male_players_ids
    @players_ids.select do |id| 
      player = Player.find(id)
      player.gender == 'Male'
    end
  end
end

# Usage example:
# template_1 = "Hey {target}, do smthg to {female}. Then do it with {male} and {opposite}. At last, do anythig to {same} and {any}."
# template_2 = "Hey {target}! Do something to {female} and {female}. And to {same} and {same}."
# game = Game.find_by(id: 1)
# dc_1 = DareConstructor.new(template_1, game)
# dc_2 = DareConstructor.new(template_2, game)
# dc_1.construct_dare
# dc_2.construct_dare
