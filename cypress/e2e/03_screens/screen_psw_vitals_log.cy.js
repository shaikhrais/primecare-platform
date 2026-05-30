// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_vitals_log", () => {
  it("opens and verifies screen psw_vitals_log", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/observation-vitals-log (PswVitalsLogScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/observation-vitals-log");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PswVitalsLogScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvitalslog-screen").should("be.visible");
  cy.getCy("pswvitalslog-title").should("be.visible");
  cy.getCy("pswvitalslog-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PswVitalsLogScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_vitals_log");
  
  cy.task("log", "✅ PROGRESS: - Verified PswVitalsLogScreen successfully!\n");

  });
});
