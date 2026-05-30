// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_medications", () => {
  it("opens and verifies screen rpn_medications", () => {
    cy.loginAsRole("rpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rpn/medications (RpnMedicationsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/medications");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RpnMedicationsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnmedications-screen").should("be.visible");
  cy.getCy("rpnmedications-title").should("be.visible");
  cy.getCy("rpnmedications-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RpnMedicationsScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_medications");
  
  cy.task("log", "✅ PROGRESS: - Verified RpnMedicationsScreen successfully!\n");

  });
});
