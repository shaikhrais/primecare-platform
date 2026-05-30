// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_reports", () => {
  it("opens and verifies screen rn_reports", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/rn-reports (RnReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RnReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnreports-screen").should("be.visible");
  cy.getCy("rnreports-title").should("be.visible");
  cy.getCy("rnreports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RnReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified RnReportsScreen successfully!\n");

  });
});
