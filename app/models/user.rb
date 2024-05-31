# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :game, dependent: :destroy
  has_many :dares, dependent: :destroy
end
