// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_client_intake", () => {
  it("opens and verifies screen rmt_client_intake", () => {
    cy.loginAsRole("rmt");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rmt/client-intake (RmtClientIntakeScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/client-intake");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RmtClientIntakeScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtclientintake-screen").should("be.visible");
  cy.getCy("rmtclientintake-title").should("be.visible");
  cy.getCy("rmtclientintake-content").should("be.visible");
  cy.getCy("rmt-intake-form-submit").should("be.visible");
  cy.getCy("rmt-treatment-plan-save").should("be.visible");
  cy.getCy("rmt-appointment-schedule").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RmtClientIntakeScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_client_intake");
  
  cy.task("log", "✅ PROGRESS: - Verified RmtClientIntakeScreen successfully!\n");

  });
});
