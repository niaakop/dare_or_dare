# frozen_string_literal: true

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
    @dare.gsub!('{target}', @current_player.name)

    replace_dare_placeholders

    @dare
  end

  private

  def replace_dare_placeholders
    replace_players("{female}", female_players)
    replace_players("{male}", male_players)
    replace_players("{opposite}", opposite_gender_players)
    replace_players("{same}", same_gender_players)
    replace_players("{any}", @players)
  end

  def female_players
    @players.select { |player| player.female? }
  end

  def male_players
    @players.select { |player| player.male? }
  end

  def opposite_gender_players
    @current_player.female? ? male_players : female_players
  end

  def same_gender_players
    @current_player.male? ? male_players : female_players
  end

  def replace_players(placeholder, players)
    @dare.gsub!(placeholder, players.sample.name) if @dare.include?(placeholder)
  end
end
