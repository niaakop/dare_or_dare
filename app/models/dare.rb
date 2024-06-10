# frozen_string_literal: true

class Dare < ApplicationRecord
  belongs_to :user
  belongs_to :game, optional: true

  validates :template, presence: true

  def construct_dare
    if self.game.present? && self.template.present?
    	dare_constructor = DareConstructor.new(self.template, self.game)
    	self.text = dare_constructor.construct_dare 
    end
    	self.text
  end
end
