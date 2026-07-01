import { DashboardPage } from "../auth/DashboardPage";

export class PremiumConciergeDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("premium_concierge", "dashboard").then(() => {
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
