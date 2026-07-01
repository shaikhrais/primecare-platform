import { DashboardPage } from "../auth/DashboardPage";

export class FranchiseSalesDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("franchise_sales", "dashboard").then(() => {
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
