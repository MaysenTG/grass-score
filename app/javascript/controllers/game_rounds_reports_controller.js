import { Controller } from "@hotwired/stimulus";

const Dollar = new Intl.NumberFormat("en-nz", {
  style: "currency",
  currency: "NZD",
});

export default class extends Controller {
  static targets = ["chart", "gameId"];

  connect() {
    this.showLoading();

    if (this.gameIdTarget) {
      this.fetchData(null, this.gameIdTarget.innerHTML);
    }
  }

  async fetchData(event, currentGameId) {
    const gameId = currentGameId || event.target.value;
    try {
      const response = await fetch(`/api/reports/games/rounds/${gameId}`);
      const data = await response.json();
      // Check if series is nil or each series has no data
      if (!data.series) {
        this.hideLoading();
        this.chartTarget.innerHTML = "<p>No data available</p>";
        return;
      }

      this.createChart(data);
    } catch (error) {
      console.error("Error fetching data:", error);
      this.chartTarget.innerHTML = "<p>Error loading data</p>";
    } finally {
      this.hideLoading();
    }
  }

  createChart(data) {
    console.log("Creating chart with data:", data);

    const categories = data.categories[0] === "Round 0" ? data.categories : ["Round 0", ...data.categories];
    const series = (data.series || []).map((entry) => {
      const hasStartingZero = entry.data?.[0] === 0;
      const safeData = Array.isArray(entry.data) ? entry.data : [];
      const safePerRoundScores = Array.isArray(entry.perRoundScores)
        ? entry.perRoundScores
        : [];

      return {
        ...entry,
        data: hasStartingZero ? safeData : [0, ...safeData],
        perRoundScores: hasStartingZero ? safePerRoundScores : [0, ...safePerRoundScores],
      };
    });

    this.chart = Highcharts.chart(this.chartTarget, {
      chart: {
        type: "line",
        backgroundColor: "#f5f5f5",
      },
      title: {
        text: "Game Report",
      },
      xAxis: {
        categories,
      },
      yAxis: {
        title: {
          text: "Scores",
        },
      },
      lang: {
        noData: "This game has no data to display",
      },
      noData: {
        style: {
          fontWeight: "bold",
          fontSize: "15px",
          color: "#303030",
        },
      },
      tooltip: {
        formatter: function () {
          const roundIndex = this.point.index;
          const perRoundScore =
            this.series.userOptions.perRoundScores[roundIndex];
          console.log("Tooltip data:", {
            seriesName: this.series.name,
            roundIndex: roundIndex,
            perRoundScore: perRoundScore,
            cumulativeScore: this.y,
          });
          return `
            <b>${this.series.name}</b><br/>
            Round: ${this.x}<br/>
            Score for the round: ${Dollar.format(perRoundScore)}<br/>
            Total score at this round: ${Dollar.format(this.y)}
          `;
        },
      },
      series,
    });
  }

  showLoading() {
    if (this.chart) {
      this.chart.showLoading();
    } else {
      this.chartTarget.innerHTML = `
      <div class="text-center">
        <h4>Loading data...</h4>
        <div class="spinner-border" role="status">
          <span class="visually-hidden">Loading...</span>
        </div>
      </div>
      `;
    }
  }

  hideLoading() {
    if (this.chart) {
      this.chart.hideLoading();
    } else {
      this.chartTarget.innerHTML = "";
    }
  }
}
