import { DashboardPage } from "../auth/DashboardPage";

export class CtoDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("cto", "dashboard").then(() => {
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
