import { DashboardPage } from "../auth/DashboardPage";

export class RegionalBdmDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("regional_bdm", "dashboard").then(() => {
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
