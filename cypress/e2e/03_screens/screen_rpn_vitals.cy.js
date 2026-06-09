// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_vitals", () => {
  it("opens and verifies screen rpn_vitals", () => {
    cy.loginAsRole("rpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rpn/vitals (RpnVitalsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/vitals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RpnVitalsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnvitals-screen").should("be.visible");
  cy.getCy("rpnvitals-title").should("be.visible");
  cy.getCy("rpnvitals-content").should("be.visible");
  cy.getCy("rpn-vitals-monitor").should("be.visible");
  cy.getCy("rpn-medication-track").should("be.visible");
  cy.getCy("rpn-careplan-update").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RpnVitalsScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_vitals");
  
  cy.task("log", "✅ PROGRESS: - Verified RpnVitalsScreen successfully!\n");

  });
});
