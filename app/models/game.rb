class Game < ApplicationRecord
  default_scope { order(created_at: :desc) }

  has_many :players, dependent: :destroy
  has_many :rounds, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validate :winning_score_greater_than_highest_player_score, on: :update

  def leading_player
    players.max_by { |player| player.scores.sum(&:total_final_score) }
  end

  def leading_score
    leading_player.scores.sum(&:total_final_score)
  end

  private

  def winning_score_greater_than_highest_player_score
    highest_player_score = players.map { |player| player.scores.sum(&:total_final_score) }.max
    return if winning_score > highest_player_score

    errors.add(:winning_score, "must be greater than the highest score than the highest player score of $#{format_number(highest_player_score)}")
  end

  def format_number(number)
    num_groups = number.to_s.chars.to_a.reverse.each_slice(3)
    num_groups.map(&:join).join(",").reverse
  end
end
