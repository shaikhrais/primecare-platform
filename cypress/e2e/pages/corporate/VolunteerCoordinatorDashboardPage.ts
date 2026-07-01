import { DashboardPage } from "../auth/DashboardPage";

export class VolunteerCoordinatorDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("volunteer_coordinator", "dashboard").then(() => {
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
