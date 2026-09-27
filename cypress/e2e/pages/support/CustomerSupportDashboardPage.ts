import { DashboardPage } from "../auth/DashboardPage";

export class CustomerSupportDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("customer_support", "dashboard").then(() => {
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
