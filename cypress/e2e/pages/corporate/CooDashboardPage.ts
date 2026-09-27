import { DashboardPage } from "../auth/DashboardPage";

export class CooDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("coo", "dashboard").then(() => {
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
