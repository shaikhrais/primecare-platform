import { DashboardPage } from "../auth/DashboardPage";

export class MarketingDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("marketing", "dashboard").then(() => {
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
