// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - marketing_manager_campaigns", () => {
  it("opens and verifies screen marketing_manager_campaigns", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/marketing_manager/campaigns (Marketing Manager Campaigns)...");
  cy.visitWithSemantics("/offices/franchise/roles/marketing_manager/campaigns");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Marketing Manager Campaigns...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("marketingmanagercampaigns-screen").should("be.visible");
  cy.getCy("marketingmanagercampaigns-title").should("be.visible");
  cy.getCy("marketingmanagercampaigns-content").should("be.visible");
  cy.getCy("marketing-dashboard-btn-adjust-strategy").should("be.visible");
  cy.getCy("marketing-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("marketing-dashboard-btn-collaborate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Marketing Manager Campaigns...");
  cy.waitAndSee();
  cy.screenshot("marketing_manager_campaigns");
  
  cy.task("log", "✅ PROGRESS: - Verified Marketing Manager Campaigns successfully!\n");

  });
});
