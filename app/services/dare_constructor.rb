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
    replace_players("{opposite}", @current_player.female? ? male_players : female_players)
    replace_players("{same}", @current_player.male? ? male_players : female_players)
    replace_players("{any}", @players)
    @dare
  end

  private

  def replace_players(placeholder, preselected_players)
    while @dare.include?(placeholder) && preselected_players.any?
      player = preselected_players.sample
      @dare.sub!(placeholder, player.name)
      @players.delete(player)
      preselected_players.delete(player)
    end
  end

  def female_players
    @players.select { |player| player.female? }
  end

  def male_players
    @players.select { |player| player.male? }
  end
end
