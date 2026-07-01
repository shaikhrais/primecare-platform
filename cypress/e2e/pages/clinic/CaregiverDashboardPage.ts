import { DashboardPage } from "../auth/DashboardPage";

export class CaregiverDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("caregiver", "dashboard").then(() => {
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
