import { DashboardPage } from "../auth/DashboardPage";

export class HrHiringDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("hr_hiring", "dashboard").then(() => {
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
