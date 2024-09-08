class Player < ApplicationRecord
  default_scope { order(created_at: :asc) }

  belongs_to :game
  belongs_to :user, optional: true
  has_many :scores, dependent: :destroy
  has_many :winning_rounds, class_name: "Round", foreign_key: "winner_id", dependent: :nullify

  validates :name, uniqueness: { scope: :game_id }
  validates :name, presence: true
  validate :can_be_deleted?, on: :destroy

  def name
    super || user&.name
  end

  private

  def can_be_deleted?
    return if game.rounds.empty? || game.rounds.all?(&:finished?)

    errors.add(:base, "Cannot delete a player while a game is in progress.")
  end
end
