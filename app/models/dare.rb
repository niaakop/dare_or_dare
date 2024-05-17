class Dare < ApplicationRecord
  belongs_to :user
  belongs_to :game, optional: true

  validates :template, presence: true

  def construct_dare
    dare_constructor = DareConstructor.new(self.template, self.game)
    if self.game.present? 
    	self.text = dare_constructor.construct_dare 
    else
    	self.text
    end
  end
end
