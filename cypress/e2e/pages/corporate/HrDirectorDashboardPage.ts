import { DashboardPage } from "../auth/DashboardPage";

export class HrDirectorDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("hr_director", "dashboard").then(() => {
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
