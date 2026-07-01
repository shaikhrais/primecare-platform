import { DashboardPage } from "../auth/DashboardPage";

export class CisoDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("ciso", "dashboard").then(() => {
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
