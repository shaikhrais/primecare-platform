import { DashboardPage } from "../auth/DashboardPage";

export class LegalDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("legal", "dashboard").then(() => {
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
