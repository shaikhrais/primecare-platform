import { DashboardPage } from "../auth/DashboardPage";

export class ShareholderDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("shareholder", "dashboard").then(() => {
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
