class Game < ActiveRecord::Base
  belongs_to :winner, class_name: "Player"

  has_many :game_players
  has_many :players, through: :game_players
end
