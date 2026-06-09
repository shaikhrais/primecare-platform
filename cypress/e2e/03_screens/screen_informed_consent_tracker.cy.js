// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - informed_consent_tracker", () => {
  it("opens and verifies screen informed_consent_tracker", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Informed Consent Tracker)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Informed Consent Tracker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("informedconsenttracker-screen").should("be.visible");
  cy.getCy("informedconsenttracker-title").should("be.visible");
  cy.getCy("informedconsenttracker-content").should("be.visible");
  cy.getCy("consent-status-overview").should("be.visible");
  cy.getCy("consent-alerts").should("be.visible");
  cy.getCy("consent-metrics-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Informed Consent Tracker...");
  cy.waitAndSee();
  cy.screenshot("informed_consent_tracker");
  
  cy.task("log", "✅ PROGRESS: - Verified Informed Consent Tracker successfully!\n");

  });
});
