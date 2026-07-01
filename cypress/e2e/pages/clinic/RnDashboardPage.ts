import { DashboardPage } from "../auth/DashboardPage";

export class RnDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("rn", "dashboard").then(() => {
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
