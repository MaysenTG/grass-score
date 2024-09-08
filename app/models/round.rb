class Round < ApplicationRecord
  default_scope { order(sid: :asc) }

  WIN_BONUS = 25_000.freeze

  belongs_to :game
  has_many :scores, dependent: :destroy
  has_one :winner, class_name: "Player", foreign_key: "id", primary_key: "winner_id"

  before_validation :set_sid, on: :create
  validate :round_has_completed?, on: :update
  validate :can_create_new_round?, on: :create

  def set_sid
    return self.sid = 1 if game.rounds.where.not(id: id).empty?

    latest_round_sid = game.rounds.where.not(id: id).last.sid
    self.sid = latest_round_sid + 1
  end

  def can_create_new_round?
    return errors.add(:base, "Cannot create a new round until there are at least 2 players.") if game.rounds.empty?

    if game.rounds.where.not(id: self.id).any? { |round| !round.finished? }
      errors.add(:base, "Cannot create a new round until all previous rounds are finished.")
    end

    if game.players.count < 2
      errors.add(:base, "Cannot create a new round until there are at least 2 players.")
    end
  end

  def round_has_completed?
    return if scores.count == game.players.count

    errors.add(:scores, "All players must have a score for the round.")
  end

  def can_be_finished?
    scores.count == game.players.count
  end

  def finish!
    return if finished?

    highest_score = scores.max_by(&:total_final_score)
    highest_score.update!(round_win_bonus: WIN_BONUS, total_final_score: highest_score.total_final_score + WIN_BONUS)
    update!(finished: true, winner_id: highest_score.player_id)
  end
end
