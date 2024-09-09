class Game < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :account
  has_many :players, dependent: :destroy
  has_many :rounds, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validate :winning_score_greater_than_highest_player_score, on: :update
  validate :can_be_finished?, on: :update, if: :finished_changed?

  def leading_player
    players.max_by { |player| player.scores.sum(&:total_final_score) }
  end

  def leading_score
    leading_player.scores.sum(&:total_final_score)
  end

  private

  def can_be_finished?
    return errors.add(:base, "This game has no rounds and can't be finished") if rounds.empty?
    return errors.add(:base, "This game has an in progress round and can't be finished") if rounds.exists?(finished: false)
    errors.add(:base, "This game has already been finished") if finished && rounds.all?(&:finished?)
  end

  def winning_score_greater_than_highest_player_score
    highest_player_score = players.map { |player| player.scores.sum(&:total_final_score) }.max
    return if highest_player_score.nil?
    return if winning_score > highest_player_score

    errors.add(:winning_score, "must be greater than the highest score than the highest player score of $#{format_number(highest_player_score)}")
  end

  def format_number(number)
    num_groups = number.to_s.chars.to_a.reverse.each_slice(3)
    num_groups.map(&:join).join(",").reverse
  end
end
