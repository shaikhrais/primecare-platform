import { DashboardPage } from "../auth/DashboardPage";

export class TerritorySalesDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("territory_sales", "dashboard").then(() => {
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
