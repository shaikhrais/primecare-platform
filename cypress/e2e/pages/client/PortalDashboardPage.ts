import { DashboardPage } from "../auth/DashboardPage";

export class PortalDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("portal", "dashboard").then(() => {
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
