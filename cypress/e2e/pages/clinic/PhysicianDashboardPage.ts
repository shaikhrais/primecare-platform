import { DashboardPage } from "../auth/DashboardPage";

export class PhysicianDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("physician", "dashboard").then(() => {
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
