import { DashboardPage } from "../auth/DashboardPage";

export class HswDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("hsw", "dashboard").then(() => {
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
