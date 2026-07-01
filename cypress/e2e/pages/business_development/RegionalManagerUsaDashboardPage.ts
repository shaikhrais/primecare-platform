import { DashboardPage } from "../auth/DashboardPage";

export class RegionalManagerUsaDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("regional_manager_usa", "dashboard").then(() => {
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
