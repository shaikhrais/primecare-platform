// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_compliance", () => {
  it("opens and verifies screen intake_coordinator_compliance", () => {
    cy.loginAsRole("intake");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/intake_coordinator/coordinator-compliance (IntakeCoordinatorComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/coordinator-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for IntakeCoordinatorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorcompliance-screen").should("be.visible");
  cy.getCy("intakecoordinatorcompliance-title").should("be.visible");
  cy.getCy("intakecoordinatorcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for IntakeCoordinatorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified IntakeCoordinatorComplianceScreen successfully!\n");

  });
});
