// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_command_center", () => {
  it("opens and verifies screen rpn_command_center", () => {
    cy.loginAsRole("rpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rpn/rpn-command-center (RpnCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RpnCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpncommandcenter-screen").should("be.visible");
  cy.getCy("rpncommandcenter-title").should("be.visible");
  cy.getCy("rpncommandcenter-content").should("be.visible");
  cy.getCy("rpn-dashboard-btn-view-patient").should("be.visible");
  cy.getCy("rpn-dashboard-btn-audit-compliance").should("be.visible");
  cy.getCy("rpn-dashboard-btn-log-interaction").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RpnCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_command_center");
  
  cy.task("log", "✅ PROGRESS: - Verified RpnCommandCenterScreen successfully!\n");

  });
});
