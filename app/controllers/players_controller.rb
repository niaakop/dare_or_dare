class PlayersController < ApplicationController
	def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      update_game_with_current_player(@player)
      redirect_to @player, notice: 'Player was successfully created.'
    else
      render :new
    end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update(player_params)
      redirect_to @player, notice: 'Player was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    redirect_to players_url, notice: 'Player was successfully destroyed.'
  end

  private

  def player_params
    params.require(:player).permit(:name, :gender, :game_id)
  end

  def update_game_with_current_player(player)
    game = player.game
    game.update(current_player_id: player.id) if game.present?
  end
end
