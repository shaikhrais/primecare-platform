import { DashboardPage } from "../auth/DashboardPage";

export class GovernanceDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("governance", "dashboard").then(() => {
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
