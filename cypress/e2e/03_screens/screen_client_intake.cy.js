// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - client_intake", () => {
  it("opens and verifies screen client_intake", () => {
    cy.loginAsRole("intake");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/intake_coordinator/client-intake (ClientIntakeScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/client-intake");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ClientIntakeScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientintake-screen").should("be.visible");
  cy.getCy("clientintake-title").should("be.visible");
  cy.getCy("clientintake-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ClientIntakeScreen...");
  cy.waitAndSee();
  cy.screenshot("client_intake");
  
  cy.task("log", "✅ PROGRESS: - Verified ClientIntakeScreen successfully!\n");

  });
});
