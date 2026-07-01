import { DashboardPage } from "../auth/DashboardPage";

export class RpnDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("rpn", "dashboard").then(() => {
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
