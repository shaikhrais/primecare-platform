import { DashboardPage } from "../auth/DashboardPage";

export class CnsDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("cns", "dashboard").then(() => {
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
