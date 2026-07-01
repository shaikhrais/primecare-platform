import { DashboardPage } from "../auth/DashboardPage";

export class RnFieldSupervisorDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("rn_field_supervisor", "dashboard").then(() => {
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
