import { DashboardPage } from "../auth/DashboardPage";

export class VolunteerDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("volunteer", "dashboard").then(() => {
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
