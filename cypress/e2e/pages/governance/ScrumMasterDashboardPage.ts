import { DashboardPage } from "../auth/DashboardPage";

export class ScrumMasterDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("scrum_master", "dashboard").then(() => {
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
