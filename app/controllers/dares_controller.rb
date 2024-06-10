# frozen_string_literal: true

class DaresController < ApplicationController
  before_action :authenticate_user!

  def index
    @dares = current_user.dares
  end

  def new
    @dare = current_user.dares.build
  end

  def create
    @dare = current_user.dares.build(dare_params)
    @dare.user = current_user
    @dare.game = current_user.game
    if @dare.save
      redirect_to @dare, notice: I18n.t('notices.dare_created')
    else
      render :new
    end
  end

  private

  def dare_params
    params.require(:dare).permit(:template)
  end
end
