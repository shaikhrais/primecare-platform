import { DashboardPage } from "../auth/DashboardPage";

export class TrainingDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("training", "dashboard").then(() => {
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
