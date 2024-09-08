module Reports
  module Games
    class PlayerScores
      attr_reader :games, :user, :players

      def initialize(user)
        @user = user
        @players = user.players
        @games = players.map(&:game).flatten.uniq.sort_by(&:created_at)
      end

      def self.call(user)
        new(user).call
      end

      def call
        {
          categories: categories,
          series: series,
        }
      end

      private

      def categories
        games.flat_map { |game| game.rounds.map { |round| "Game #{game.id} - Round #{round.sid}" } }
      end

      def series
        games.flat_map do |game|
          players.map do |player|
            player_data = game.rounds.where(finished: true).map { |round| calculate_round_score(player, round) }
            aggregated_data = player_data.each_with_index.map { |score, index| player_data[0..index].sum }

            next if player_data.all?(&:zero?)

            {
              name: "#{player.name} - #{game.name}",
              data: aggregated_data,
              per_round_data: player_data,
            }
          end
        end.compact
      end

      def calculate_round_score(player, round)
        score = round.scores.find_by(player_id: player.id)
        score ? score.total_final_score : 0
      end
    end
  end
end
