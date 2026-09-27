import { DashboardPage } from "../auth/DashboardPage";

export class TrainingCoordinatorDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("training_coordinator", "dashboard").then(() => {
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
