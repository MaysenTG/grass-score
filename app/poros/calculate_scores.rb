class CalculateScores
  PARANOIA_CARD_VALUES = {
    "sold_out" => -25_000,
    "double_crossed" => -50_000,
    "utterly_wiped_out" => -100_000,
  }.freeze

  attr :score, :scores, :round

  def initialize(round)
    @round = round
    @scores = @round.scores
  end

  def self.call(round)
    new(round).call
  end

  def call
    remove_banker_counts if no_player_has_banker?

    set_pre_banker_score
    scores.each(&:reload)
    add_banker_values_to_banker
    remove_banker_deductions_from_non_bankers

    scores.each(&:reload)

    set_final_score_with_banker_value
  end

  private

  def no_player_has_banker?
    scores.none?(&:banker?)
  end

  def remove_banker_counts
    scores.each do |score|
      total_score = pre_banker_score(score)
      score.update!(banker: false, banker_value: 0, total_pre_banker_score: total_score, total_final_score: total_score)
    end
  end

  def add_banker_values_to_banker
    banker = scores.find_by(banker: true)
    return unless banker

    total_to_add_to_banker = scores.where.not(banker: true).sum(&:unprotected_peddle) * 0.2
    banker.update!(banker_value: total_to_add_to_banker)
  end

  def remove_banker_deductions_from_non_bankers
    return unless scores.exists?(banker: true)

    scores.where.not(banker: true).each do |score|
      next if score.total_pre_banker_score <= 0

      score.update!(banker_value: score.unprotected_peddle * -0.2)
    end
  end

  def set_pre_banker_score
    scores.each do |score|
      score.update!(total_pre_banker_score: pre_banker_score(score))
    end
  end

  def set_final_score_with_banker_value
    scores.each do |score|
      score.update!(total_final_score: pre_banker_score(score) + score.banker_value)
    end
  end

  def pre_banker_score(score)
    # Doesn't include banker deductions
    puts "TOTAL PARANOIA POINTS: #{total_paranoia_points(score)}"
    puts "UNPROTECTED PEDDLE: #{score.unprotected_peddle}"
    puts "PROTECTED PEDDLE: #{score.protected_peddle}"
    puts "HIGHEST PEDDLE IN HAND: #{score.highest_peddle_in_hand}"
    [total_paranoia_points(score), score.unprotected_peddle, score.protected_peddle, -score.highest_peddle_in_hand.to_i].sum
  end

  def total_paranoia_points(score)
    paranoia_points = 0
    paranoia_points += PARANOIA_CARD_VALUES["sold_out"] if score.num_sold_out.positive?
    paranoia_points += PARANOIA_CARD_VALUES["double_crossed"] if score.num_double_crossed.positive?
    paranoia_points += PARANOIA_CARD_VALUES["utterly_wiped_out"] if score.num_utterly_wiped_out.positive?
    paranoia_points.to_i
  end
end
