// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - infrastructure_compliance", () => {
  it("opens and verifies screen infrastructure_compliance", () => {
    cy.loginAsRole("infrastructure");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/infrastructure-compliance (InfrastructureComplianceScreen)...");
  cy.visitWithSemantics("/common/infrastructure-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for InfrastructureComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructurecompliance-screen").should("be.visible");
  cy.getCy("infrastructurecompliance-title").should("be.visible");
  cy.getCy("infrastructurecompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for InfrastructureComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("infrastructure_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified InfrastructureComplianceScreen successfully!\n");

  });
});
