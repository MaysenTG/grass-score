class Game < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :account
  has_many :players, dependent: :destroy
  has_many :rounds, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validate :can_be_finished?, on: :update, if: :finished_changed?

  def leading_player
    players.max_by { |player| player.scores.sum(&:total_final_score) }
  end

  def leading_score
    leading_player.scores.sum(&:total_final_score)
  end

  private

  def can_be_finished?
    errors.add(:base, "This game has no rounds and can't be finished") if rounds.empty?
    errors.add(:base, "This game has an in progress round and can't be finished") if rounds.exists?(finished: false)
  end

  def format_number(number)
    num_groups = number.to_s.chars.to_a.reverse.each_slice(3)
    num_groups.map(&:join).join(",").reverse
  end
end
