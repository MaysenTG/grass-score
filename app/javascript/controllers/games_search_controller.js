import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.timeout = null;
  }

  perform() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      const inputValue = this.inputTarget.value;
      const url = new URL(window.location.href);

      if (inputValue) {
        url.searchParams.set("name", inputValue);
      } else {
        url.searchParams.delete("name");
      }

      window.history.replaceState({}, "", url);
      this.element.requestSubmit();
    }, 300); // Adjust the debounce delay as needed
  }

  clearAndRefetch() {
    this.inputTarget.value = ""; // Clear the inputTarget value
    const url = new URL(window.location.href);
    url.searchParams.delete("name");
    window.history.replaceState({}, "", url);
    this.element.requestSubmit();
  }
}
