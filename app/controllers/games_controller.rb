class GamesController < ApplicationController
  def show
    @dares = ["Dare 1", "Dare 2", "Dare 3", "Dare 4", "Dare 5"] # Assuming you have an array of dares
    @selected_dare = @dares.sample
  end
end
