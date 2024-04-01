class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :next_player]

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @current_player = @game.current_player  
    @selected_dare = @game.selected_dare
  end

  def new
    @game = Game.new
  end

  def next_player
    @game.select_next_player
    redirect_to game_path(@game)
  end

  def edit
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  def update
    if @game.update(game_params)
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @game.destroy
    redirect_to games_url, notice: 'Game was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:name)
    end
end
