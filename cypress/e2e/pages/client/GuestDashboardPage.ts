import { DashboardPage } from "../auth/DashboardPage";

export class GuestDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("guest", "dashboard").then(() => {
      this.assertLoaded();
      this.assertRequiredComponents();
    });
    return this;
  }

  clickBtn(index: number) {
    this.getButton(index).click({ force: true });
    return this;
  }
}
