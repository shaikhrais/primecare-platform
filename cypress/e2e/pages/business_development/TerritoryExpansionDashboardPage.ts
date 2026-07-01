import { DashboardPage } from "../auth/DashboardPage";

export class TerritoryExpansionDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("territory_expansion", "dashboard").then(() => {
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
