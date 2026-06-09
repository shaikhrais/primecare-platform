// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - vaccination_campaign_manager", () => {
  it("opens and verifies screen vaccination_campaign_manager", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Vaccination Campaign Manager)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Vaccination Campaign Manager...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vaccinationcampaignmanager-screen").should("be.visible");
  cy.getCy("vaccinationcampaignmanager-title").should("be.visible");
  cy.getCy("vaccinationcampaignmanager-content").should("be.visible");
  cy.getCy("campaign-manager-btn-create").should("be.visible");
  cy.getCy("campaign-manager-btn-schedule").should("be.visible");
  cy.getCy("campaign-manager-btn-update").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Vaccination Campaign Manager...");
  cy.waitAndSee();
  cy.screenshot("vaccination_campaign_manager");
  
  cy.task("log", "✅ PROGRESS: - Verified Vaccination Campaign Manager successfully!\n");

  });
});
