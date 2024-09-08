import { Controller } from "@hotwired/stimulus";

const Dollar = new Intl.NumberFormat("en-nz", {
  style: "currency",
  currency: "NZD",
});

export default class extends Controller {
  static targets = ["chart", "userId"];

  connect() {
    this.showLoading();
    this.fetchData({ target: { value: this.userIdTarget.innerHTML } });
  }

  async fetchData(event) {
    const userId = event.target.value;
    try {
      const response = await fetch(`/api/reports/games/users/${userId}`);
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

    // Calculate the minimum score from the data
    const minScore = Math.min(...data.series.flatMap((series) => series.data));

    this.chart = Highcharts.chart(this.chartTarget, {
      chart: {
        type: "line",
      },
      title: {
        text: "Player Scores Progression",
      },
      xAxis: {
        categories: data.categories,
        title: {
          text: "Rounds",
        },
      },
      yAxis: {
        min: minScore,
        title: {
          text: "Scores",
          align: "high",
        },
        labels: {
          overflow: "justify",
        },
      },
      tooltip: {
        formatter: function () {
          const seriesIndex = this.series.index;
          const pointIndex = this.point.index;
          const perRoundScore =
            data.series[seriesIndex].per_round_data[pointIndex];
          return `<b>${this.series.name}</b><br/>Round: ${
            this.x
          }<br/>Score: ${Dollar.format(
            perRoundScore
          )}<br/>Total: ${Dollar.format(this.y)}`;
        },
      },
      plotOptions: {
        line: {
          dataLabels: {
            enabled: true,
          },
          enableMouseTracking: true,
        },
      },
      series: data.series.map((series) => ({
        name: `${series.name} (Aggregated)`,
        data: series.data.length ? series.data : [0],
      })),
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
