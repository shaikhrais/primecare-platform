import { DashboardPage } from "../auth/DashboardPage";

export class PhysioDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("physio", "dashboard").then(() => {
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
