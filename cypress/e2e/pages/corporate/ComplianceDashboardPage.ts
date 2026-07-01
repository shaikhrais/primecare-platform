import { DashboardPage } from "../auth/DashboardPage";

export class ComplianceDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("compliance", "dashboard").then(() => {
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
