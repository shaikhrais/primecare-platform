// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_clients", () => {
  it("opens and verifies screen psw_clients", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/patient-profile (PswClientsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/patient-profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PswClientsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswclients-screen").should("be.visible");
  cy.getCy("pswclients-title").should("be.visible");
  cy.getCy("pswclients-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PswClientsScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_clients");
  
  cy.task("log", "✅ PROGRESS: - Verified PswClientsScreen successfully!\n");

  });
});
