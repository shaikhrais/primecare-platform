// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_reports", () => {
  it("opens and verifies screen chiropractor_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/chiropractor/reports (ChiropractorReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ChiropractorReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorreports-screen").should("be.visible");
  cy.getCy("chiropractorreports-title").should("be.visible");
  cy.getCy("chiropractorreports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ChiropractorReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified ChiropractorReportsScreen successfully!\n");

  });
});
