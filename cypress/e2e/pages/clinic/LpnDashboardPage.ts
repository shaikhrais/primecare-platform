import { DashboardPage } from "../auth/DashboardPage";

export class LpnDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("lpn", "dashboard").then(() => {
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
