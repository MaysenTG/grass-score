module Reports
  module Games
    class RoundsCount
      attr_reader :games

      def initialize
        @games = Game.all
      end

      def self.call
        new.call
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
