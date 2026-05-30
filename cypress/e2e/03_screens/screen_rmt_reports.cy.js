// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_reports", () => {
  it("opens and verifies screen rmt_reports", () => {
    cy.loginAsRole("rmt");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rmt/reports (RmtReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RmtReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtreports-screen").should("be.visible");
  cy.getCy("rmtreports-title").should("be.visible");
  cy.getCy("rmtreports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RmtReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified RmtReportsScreen successfully!\n");

  });
});
