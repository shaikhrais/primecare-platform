import { DashboardPage } from "../auth/DashboardPage";

export class SystemVerificationDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("system_verification", "dashboard").then(() => {
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
