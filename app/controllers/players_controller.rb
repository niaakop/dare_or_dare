class PlayersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  after_action :ensure_current_player, only: [:create, :destroy]

	def index
    @players = Player.all
  end

  def show
    @players = current_user.game.players
  end

  def new
    @player = Player.new
  end

  def create
    @player = current_user.game.players.build(player_params)
    if @player.save
      redirect_to players_url, notice: 'Player was successfully created.'
    else
      render :new
    end
  end


  def edit
    @player = Player.find(params[:id])
  end

  def update
    if @player.update(player_params)
      redirect_to @player, notice: 'Player was successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    if current_user.game.current_player_id == @player.id
      current_user.game.select_next_player  
    end
    @player.destroy
    redirect_to players_url, notice: 'Player was successfully destroyed.'
  end


  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name, :gender)
  end

  def ensure_current_player
    game = current_user.game
    game.set_initial_player if game.current_player_id.nil?
  end
end
