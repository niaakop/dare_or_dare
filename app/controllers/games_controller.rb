class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: [:show, :edit, :update, :destroy, :next_player, :next_dare, :restart]

  def show
    @current_player = @game.current_player  
    @selected_dare = @game.selected_dare
  end

  def new
    redirect_to current_user.game, alert: 'You already have a game.' if current_user.game.present?
    @game = Game.new
  end

  def next_player
    @game.select_next_player
    redirect_to game_path(@game)
  end

  def next_dare
    @game.select_dare 
    redirect_to game_path(@game)
  end

  def restart
    @game.update_available_dares_ids
    next_dare
  end

  def edit
  end

  def create
    if current_user.game.present?
      redirect_to root_path, alert: 'You already have a game.'
    else
      @game = current_user.build_game(game_params)
      if @game.save
        redirect_to new_player_path(game_id: @game.id), notice: 'Game was successfully created. Now add a player!'
      else
        render :new
      end
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

  def set_game
    @game = current_user.game
    redirect_to root_path, alert: 'No such game found.' unless @game
  end

  def game_params
    params.require(:game).permit(:name)
  end
end
