import { DashboardPage } from "../auth/DashboardPage";

export class BusDevDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("bus_dev", "dashboard").then(() => {
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
