import { DashboardPage } from "../auth/DashboardPage";

export class InfrastructureDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("infrastructure", "dashboard").then(() => {
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
