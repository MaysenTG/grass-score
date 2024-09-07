import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "clearText", "loadingText"];

  connect() {
    this.timeout = null;
  }

  perform() {
    this.showLoading();
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
      this.removeLoading();
    }, 500); // Adjust the debounce delay as needed
  }

  clearAndRefetch() {
    this.inputTarget.value = ""; // Clear the inputTarget value
    const url = new URL(window.location.href);
    url.searchParams.delete("name");
    window.history.replaceState({}, "", url);
    this.element.requestSubmit();
  }

  showLoading() {
    this.loadingTextTarget.classList.remove("d-none");
    this.clearTextTarget.classList.add("d-none");
  }

  removeLoading() {
    this.loadingTextTarget.classList.add("d-none");
    this.clearTextTarget.classList.remove("d-none");
  }
}
