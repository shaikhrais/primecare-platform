import { DashboardPage } from "../auth/DashboardPage";

export class OpsManagerDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("ops_manager", "dashboard").then(() => {
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
