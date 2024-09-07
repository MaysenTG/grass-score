class Score < ApplicationRecord
  enum :highest_peddle_in_hand, { 0 => 0, 5000 => 1, 25000 => 2, 50000 => 3 }

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

  validate :score_can_be_edited?, on: :update

  def score_can_be_edited?
    if round.finished?
      errors.add(:base, "This round has already been finished")
    end
  end
end
