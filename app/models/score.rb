class Score < ApplicationRecord
  belongs_to :round
  belongs_to :player

  validates :player_id, presence: true
  validates :protected_peddle, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :unprotected_peddle, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :num_sold_out, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :num_double_crossed, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :num_utterly_wiped_out, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :banker, inclusion: { in: [true, false] }
  validates :banker, uniqueness: { scope: :round_id }, if: :banker?

  validates :highest_peddle_in_hand, presence: true, inclusion: { in: [0, 5_000, 25_000, 50_000, 100_000] }

  validate :score_can_be_edited?, on: :update

  def score_can_be_edited?
    if round.finished?
      errors.add(:base, "This round has already been finished")
    end
  end
end
