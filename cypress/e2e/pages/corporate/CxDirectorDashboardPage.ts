import { DashboardPage } from "../auth/DashboardPage";

export class CxDirectorDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("cx_director", "dashboard").then(() => {
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
