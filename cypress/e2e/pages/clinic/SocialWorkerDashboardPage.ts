import { DashboardPage } from "../auth/DashboardPage";

export class SocialWorkerDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("social_worker", "dashboard").then(() => {
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
