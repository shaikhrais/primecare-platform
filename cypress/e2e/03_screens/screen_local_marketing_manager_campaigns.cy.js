// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - local_marketing_manager_campaigns", () => {
  it("opens and verifies screen local_marketing_manager_campaigns", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Local Marketing Manager Campaigns)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Local Marketing Manager Campaigns...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagercampaigns-screen").should("be.visible");
  cy.getCy("localmarketingmanagercampaigns-title").should("be.visible");
  cy.getCy("localmarketingmanagercampaigns-content").should("be.visible");
  cy.getCy("localmarketing-btn-create").should("be.visible");
  cy.getCy("localmarketing-btn-manage").should("be.visible");
  cy.getCy("localmarketing-btn-analyze").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Local Marketing Manager Campaigns...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_campaigns");
  
  cy.task("log", "✅ PROGRESS: - Verified Local Marketing Manager Campaigns successfully!\n");

  });
});
