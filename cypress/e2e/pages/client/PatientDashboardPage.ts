import { DashboardPage } from "../auth/DashboardPage";

export class PatientDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("patient", "dashboard").then(() => {
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
