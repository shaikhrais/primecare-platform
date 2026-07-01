import { DashboardPage } from "../auth/DashboardPage";

export class CfoDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("cfo", "dashboard").then(() => {
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
