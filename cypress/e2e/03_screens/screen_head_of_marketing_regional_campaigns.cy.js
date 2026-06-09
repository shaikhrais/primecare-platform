// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_marketing_regional_campaigns", () => {
  it("opens and verifies screen head_of_marketing_regional_campaigns", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Head Of Marketing Regional Campaigns)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Head Of Marketing Regional Campaigns...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingregionalcampaigns-screen").should("be.visible");
  cy.getCy("headofmarketingregionalcampaigns-title").should("be.visible");
  cy.getCy("headofmarketingregionalcampaigns-content").should("be.visible");
  cy.getCy("dashboard-btn-adjust-campaign").should("be.visible");
  cy.getCy("dashboard-btn-generate-report").should("be.visible");
  cy.getCy("dashboard-btn-collaborate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Head Of Marketing Regional Campaigns...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_regional_campaigns");
  
  cy.task("log", "✅ PROGRESS: - Verified Head Of Marketing Regional Campaigns successfully!\n");

  });
});
