import { DashboardPage } from "../auth/DashboardPage";

export class ChiropractorDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("chiropractor", "dashboard").then(() => {
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
