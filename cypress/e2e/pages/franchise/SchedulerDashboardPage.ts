import { DashboardPage } from "../auth/DashboardPage";

export class SchedulerDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("scheduler", "dashboard").then(() => {
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
