module Reports
  module Games
    class Rounds
      attr_reader :game, :rounds, :players

      def initialize(game)
        @game = game
        @rounds = game.rounds.where(finished: true)
        @players = game.players
      end

      def self.call(game)
        new(game).call
      end

      def call
        {
          game: game,
          categories: categories,
          series: series,
        }
      end

      private

      def categories
        ["Round 0"] + rounds.map { |round| "Round #{round.sid}" }
      end

      def series
        cumulative_scores = Hash.new { |hash, key| hash[key] = 0 }

        players.map do |player|
          per_round_scores = [0] + rounds.map { |round| calculate_total_score(player, round) }
          cumulative_data = [0]

          rounds.each do |round|
            cumulative_scores[player.id] += calculate_total_score(player, round)
            cumulative_data << cumulative_scores[player.id]
          end

          {
            name: player.name,
            data: cumulative_data,
            perRoundScores: per_round_scores,
          }
        end
      end

      def calculate_total_score(player, round)
        scores = round.scores.where(player_id: player.id)
        scores.sum(:total_final_score)
      end
    end
  end
end
