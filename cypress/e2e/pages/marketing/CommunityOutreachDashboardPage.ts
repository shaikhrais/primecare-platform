import { DashboardPage } from "../auth/DashboardPage";

export class CommunityOutreachDashboardPage extends DashboardPage {
  isLoaded() {
    this.initializeFromDb("community_outreach", "dashboard").then(() => {
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
