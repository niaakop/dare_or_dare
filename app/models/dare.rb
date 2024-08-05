# frozen_string_literal: true

class Dare < ApplicationRecord
  belongs_to :user
  belongs_to :game, optional: true

  validates :template, presence: true

  def construct_dare
    return unless self.game.present? && self.template.present?

   	dare_constructor = DareConstructor.new(self.template, self.game)
   	dare_constructor.construct_dare 
  end
end
