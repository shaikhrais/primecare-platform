// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_compliance", () => {
  it("opens and verifies screen intake_compliance", () => {
    cy.loginAsRole("intake");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/intake_coordinator/compliance (IntakeComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for IntakeComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecompliance-screen").should("be.visible");
  cy.getCy("intakecompliance-title").should("be.visible");
  cy.getCy("intakecompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for IntakeComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified IntakeComplianceScreen successfully!\n");

  });
});
