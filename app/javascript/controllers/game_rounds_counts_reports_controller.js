import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["chart"];

  connect() {
    this.showLoading();
    this.fetchData();
  }

  async fetchData() {
    try {
      const response = await fetch(`/api/reports/games/round_counts`);
      const data = await response.json();
      // Check if series is nil or each series has no data
      if (
        !data.series ||
        data.series.length === 0 ||
        data.series[0].data.length === 0
      ) {
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
    this.chart = Highcharts.chart(this.chartTarget, {
      chart: {
        type: "bar",
      },
      title: {
        text: "Number of Rounds per Game",
      },
      xAxis: {
        categories: data.categories,
        title: {
          text: "Games",
        },
      },
      yAxis: {
        min: 0,
        title: {
          text: "Number of Rounds",
          align: "high",
        },
        labels: {
          overflow: "justify",
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
        valueSuffix: " rounds",
      },
      plotOptions: {
        bar: {
          dataLabels: {
            enabled: true,
          },
        },
      },
      series: data.series,
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
