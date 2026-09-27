import { DashboardPage } from "../auth/DashboardPage";

export class DynamicDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("dynamic", "dashboard").then(() => {
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
