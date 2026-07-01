import { DashboardPage } from "../auth/DashboardPage";

export class NpDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("np", "dashboard").then(() => {
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
