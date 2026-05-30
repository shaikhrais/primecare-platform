// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - audit", () => {
  it("opens and verifies screen audit", () => {
    cy.loginAsRole("governance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/audit (ScreenAuditScreen)...");
  cy.visitWithSemantics("/common/audit");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ScreenAuditScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("audit-screen").should("be.visible");
  cy.getCy("audit-title").should("be.visible");
  cy.getCy("audit-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ScreenAuditScreen...");
  cy.waitAndSee();
  cy.screenshot("audit");
  
  cy.task("log", "✅ PROGRESS: - Verified ScreenAuditScreen successfully!\n");

  });
});
