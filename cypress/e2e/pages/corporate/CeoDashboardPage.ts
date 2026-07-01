import { DashboardPage } from "../auth/DashboardPage";

export class CeoDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("ceo", "dashboard").then(() => {
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
