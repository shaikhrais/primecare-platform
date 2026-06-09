// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_marketing_campaigns", () => {
  it("opens and verifies screen head_of_marketing_campaigns", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Head Of Marketing Campaigns)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Head Of Marketing Campaigns...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingcampaigns-screen").should("be.visible");
  cy.getCy("headofmarketingcampaigns-title").should("be.visible");
  cy.getCy("headofmarketingcampaigns-content").should("be.visible");
  cy.getCy("dashboard-btn-adjust-strategy").should("be.visible");
  cy.getCy("dashboard-btn-review-budget").should("be.visible");
  cy.getCy("dashboard-btn-report-results").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Head Of Marketing Campaigns...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_campaigns");
  
  cy.task("log", "✅ PROGRESS: - Verified Head Of Marketing Campaigns successfully!\n");

  });
});
