# Usage example:
# game = Game.find_by(id:1)
# template_1 = "Hey {target}, do smthg to {female}. Then do it with {male} and {opposite}. At last, do anything to {same} and {any}."
# dc_1 = DareConstructor.new(template_1, game)
# dc_1.construct_dare

class DareConstructor
  def initialize(template, game)
    @template = template
    @game = game
    @players = []
    @current_player = @game.current_player
  end

  def construct_dare
    @players = @game.players.where.not(id: @current_player.id).to_a
    @dare = @template.dup
    @dare.gsub!("{target}", @current_player.name)
    replace_players("{female}", female_players)
    replace_players("{male}", male_players)
    replace_players("{opposite}", @current_player.gender == 'Female' ? male_players : female_players)
    replace_players("{same}", @current_player.gender == 'Male' ? male_players : female_players)
    replace_players("{any}", @players)
    @dare
  end

  private

  def replace_players(placeholder, players)
    while @dare.include?(placeholder) && players.any?
      player = players.sample
      @dare.sub!(placeholder, player.name)
      @players.delete(player)
      players.delete(player)
    end
    @dare
  end

  def female_players
    @players.select { |player| player.gender == 'Female' }
  end

  def male_players
    @players.select { |player| player.gender == 'Male' }
  end
end
