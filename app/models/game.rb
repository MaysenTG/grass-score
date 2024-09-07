class Game < ApplicationRecord
  default_scope { order(created_at: :desc) }

  has_many :players
  has_many :rounds

  validates :name, presence: true

  def leading_player
    players.max_by { |player| player.scores.sum(&:total_final_score) }
  end
end
