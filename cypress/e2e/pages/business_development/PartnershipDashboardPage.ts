import { DashboardPage } from "../auth/DashboardPage";

export class PartnershipDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("partnership", "dashboard").then(() => {
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
