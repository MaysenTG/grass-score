module Reports
  module Games
    class RoundsCount
      attr_reader :games

      def initialize(current_account)
        @games = current_account.games
      end

      def self.call(current_account)
        new(current_account).call
      end

      def call
        {
          categories: categories,
          series: series,
        }
      end

      private

      def categories
        sorted_games.map(&:name)
      end

      def series
        [{
          name: "Number of Rounds",
          data: sorted_games.map { |game| game.rounds.where(finished: true).count },
        }]
      end

      def sorted_games
        @sorted_games ||= games.sort_by { |game| -game.rounds.where(finished: true).count }
      end
    end
  end
end
