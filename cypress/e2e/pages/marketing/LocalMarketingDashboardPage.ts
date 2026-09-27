import { DashboardPage } from "../auth/DashboardPage";

export class LocalMarketingDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("local_marketing", "dashboard").then(() => {
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
