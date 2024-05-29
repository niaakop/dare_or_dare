# Usage example:
# game = Game.find_by(id:1),
# template_1 = "Hey {target}, do smthg to {female}. Then do it with {male} and {opposite}. At last, do anythig to {same} and {any}."
# dc_1 = DareConstructor.new(template_1, game)
# dc_1.construct_dare

class DareConstructor
  def initialize(template, game)
    @template = template
    @game = game
    @players = []
  end

  def construct_dare
    @players = @game.players.where.not(id: current_player.id).to_a
    dare = @template.dup
    dare.gsub!("{target}", current_player.name)
    dare = replace_players(dare, "{female}", female_players)
    dare = replace_players(dare, "{male}", male_players)
    dare = replace_players(dare, "{opposite}", current_player.gender == 'Female' ? male_players : female_players)
    dare = replace_players(dare, "{same}", current_player.gender == 'Male' ? male_players : female_players)
    dare = replace_players(dare, "{any}", @players)
    dare
  end

  private

  def replace_players(dare, placeholder, players)
    while dare.include?(placeholder) && players.any?
      player = players.sample
      dare.sub!(placeholder, player.name)
      @players.delete(player)
      players.delete(player)
    end
    dare
  end

  def current_player
    @game.current_player
  end

  def female_players
    @players.select { |player| player.gender == 'Female' }
  end

  def male_players
    @players.select { |player| player.gender == 'Male' }
  end
end
