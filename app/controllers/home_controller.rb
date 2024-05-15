class HomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.game
        redirect_to game_path(current_user.game)
      else
        redirect_to new_game_path
      end
    else
      redirect_to new_user_session_path
    end
  end
end
