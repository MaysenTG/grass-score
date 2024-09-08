import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "playerIdSelect", "suggestedUserContainer"];

  connect() {
    this.debounceFetchUser = this.debounce(this.fetchUser, 300);
  }

  debounce(func, wait) {
    let timeout;
    return (...args) => {
      clearTimeout(timeout);
      if (this.playerIdSelectTarget.value) {
        this.clearSuggestedUser();
        return;
      }
      this.showLoadingPlaceholder();
      timeout = setTimeout(() => func.apply(this, args), wait);
    };
  }

  async fetchUser() {
    const playerName = this.inputTarget.value;
    if (playerName.length < 3) {
      this.clearSuggestedUser();
      return;
    }

    try {
      const response = await fetch(`/api/users/suggested?name=${playerName}`);
      const data = await response.json();
      this.updateSuggestedUser(data);
    } catch (error) {
      console.error("Error fetching suggested user:", error);
      this.clearSuggestedUser();
    }
  }

  showLoadingPlaceholder() {
    const suggestedUserContainer = this.suggestedUserContainerTarget;
    suggestedUserContainer.innerHTML = `
      <h4>Suggested users:</h4>
      <ul>
        <li>
          <div class="placeholder col-1 placeholder-xs"></div>
        </li>
        <li>
          <div class="placeholder col-1 placeholder-xs"></div>
        </li>
      </ul>
    `;
  }

  updateSuggestedUser(users) {
    const suggestedUserContainer = this.suggestedUserContainerTarget;

    suggestedUserContainer.innerHTML = "";

    const suggestedUserTitle = document.createElement("h4");
    suggestedUserTitle.textContent = "Suggested users:";

    suggestedUserContainer.appendChild(suggestedUserTitle);

    const userList = document.createElement("ul");
    users.forEach((user) => {
      const userItem = document.createElement("li");
      const userLink = document.createElement("a");
      userLink.href = "#";
      userLink.id = "suggested-user";
      userLink.setAttribute("data-user-id", user.id);
      userLink.textContent = user.name;
      userItem.appendChild(userLink);
      userList.appendChild(userItem);
    });

    suggestedUserContainer.appendChild(userList);

    this.addSuggestedUserClickListener();
  }

  clearSuggestedUser() {
    const suggestedUserContainer = this.suggestedUserContainerTarget;
    suggestedUserContainer.innerHTML = "";
  }

  addSuggestedUserClickListener() {
    const suggestedUserLinks = document.querySelectorAll("#suggested-user");
    suggestedUserLinks.forEach((link) => {
      link.addEventListener("click", (event) => {
        event.preventDefault();
        const userId = event.target.getAttribute("data-user-id");
        this.playerIdSelectTarget.value = userId;

        this.suggestedUserContainerTarget.innerHTML = "";
      });
    });
  }
}
