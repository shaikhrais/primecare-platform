// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - care_updates", () => {
  it("opens and verifies screen care_updates", () => {
    cy.loginAsRole("family");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/care-updates (CareUpdatesScreen)...");
  cy.visitWithSemantics("/common/care-updates");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CareUpdatesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("careupdates-screen").should("be.visible");
  cy.getCy("careupdates-title").should("be.visible");
  cy.getCy("careupdates-content").should("be.visible");
  cy.getCy("compliance-scan-results").should("be.visible");
  cy.getCy("performance-indicator-chart").should("be.visible");
  cy.getCy("operational-audit-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CareUpdatesScreen...");
  cy.waitAndSee();
  cy.screenshot("care_updates");
  
  cy.task("log", "✅ PROGRESS: - Verified CareUpdatesScreen successfully!\n");

  });
});
