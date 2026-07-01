import { DashboardPage } from "../auth/DashboardPage";

export class IntakeDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("intake", "dashboard").then(() => {
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
