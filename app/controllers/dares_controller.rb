class DaresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dare, only: [:edit, :update, :destroy]

  def index
    @dares = current_user.dares
  end

  def new
    @dare = current_user.dares.build
  end

  def edit
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

  def update
    if @dare.update(dare_params)
      redirect_to @dare, notice: I18n.t('notices.dare_updated')
    else
      render :edit
    end
  end

  def destroy
    if @dare.present?
      @dare.destroy
    else
      redirect_to dares_path
    end
  end

  private

  def set_dare
    @dare = Dare.find(params[:id])
  end

  def dare_params
    params.require(:dare).permit(:template)
  end
end
