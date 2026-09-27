import { DashboardPage } from "../auth/DashboardPage";

export class RmtDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("rmt", "dashboard").then(() => {
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
