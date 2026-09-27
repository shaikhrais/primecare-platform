import { DashboardPage } from "../auth/DashboardPage";

export class EmployeeDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("employee", "dashboard").then(() => {
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
