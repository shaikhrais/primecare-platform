// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - outreach_campaign", () => {
  it("opens and verifies screen outreach_campaign", () => {
    cy.loginAsRole("bus_dev");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/outreach-campaign (OutreachCampaignScreen)...");
  cy.visitWithSemantics("/management/outreach-campaign");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OutreachCampaignScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("outreachcampaign-screen").should("be.visible");
  cy.getCy("outreachcampaign-title").should("be.visible");
  cy.getCy("outreachcampaign-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OutreachCampaignScreen...");
  cy.waitAndSee();
  cy.screenshot("outreach_campaign");
  
  cy.task("log", "✅ PROGRESS: - Verified OutreachCampaignScreen successfully!\n");

  });
});
