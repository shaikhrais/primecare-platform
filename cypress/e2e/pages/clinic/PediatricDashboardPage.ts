import { DashboardPage } from "../auth/DashboardPage";

export class PediatricDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("pediatric", "dashboard").then(() => {
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
