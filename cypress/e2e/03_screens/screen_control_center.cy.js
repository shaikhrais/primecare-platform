// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - control_center", () => {
  it("opens and verifies screen control_center", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /governance/control-center (Control Center)...");
  cy.visitWithSemantics("/governance/control-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Control Center...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("controlcenter-screen").should("be.visible");
  cy.getCy("controlcenter-title").should("be.visible");
  cy.getCy("controlcenter-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Control Center...");
  cy.waitAndSee();
  cy.screenshot("control_center");
  
  cy.task("log", "✅ PROGRESS: - Verified Control Center successfully!\n");

  });
});
