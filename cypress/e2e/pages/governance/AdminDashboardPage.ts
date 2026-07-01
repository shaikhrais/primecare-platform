import { DashboardPage } from "../auth/DashboardPage";

export class AdminDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("admin", "dashboard").then(() => {
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
