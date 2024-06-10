# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: %i[show edit update destroy next_player next_dare restart]

  def show
    @current_player = @game.current_player
    @selected_dare = @game.selected_dare
  end

  def new
    redirect_to current_user.game, alert: I18n.t('notices.game_already_exists') if current_user.game.present?
    @game = Game.new
  end

  def next_player
    @game.select_next_player
    @game.select_dare
    redirect_to game_path(@game)
  end

  def next_dare
    @game.select_dare
    redirect_to game_path(@game)
  end

  def restart
    @game.update!(used_dare_ids: [])
    next_dare
  end

  def edit; end

  def create
    if current_user.game.present?
      redirect_to root_path, alert: I18n.t('notices.game_already_exists')
    else
      @game = current_user.build_game(game_params)
      if @game.save
        redirect_to new_player_path(game_id: @game.id), notice: I18n.t('notices.game_created_add_player')
      else
        render :new
      end
    end
  end

  def update
    if @game.update(game_params)
      redirect_to @game, notice: I18n.t('notices.game_updated')
    else
      render :edit
    end
  end

  def destroy
    @game.destroy!
    redirect_to games_url, notice: I18n.t('notices.game_destroyed')
  end

  private

  def set_game
    @game = current_user.game
    redirect_to root_path, alert: I18n.t('notices.game_not_found') unless @game
  end

  def game_params
    params.require(:game).permit(:name)
  end
end
