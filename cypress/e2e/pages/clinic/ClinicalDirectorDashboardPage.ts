import { DashboardPage } from "../auth/DashboardPage";

export class ClinicalDirectorDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("clinical_director", "dashboard").then(() => {
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
