import { DashboardPage } from "../auth/DashboardPage";

export class QaSpecialistDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("qa_specialist", "dashboard").then(() => {
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
