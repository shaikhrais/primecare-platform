// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_client_profile", () => {
  it("opens and verifies screen psw_client_profile", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/psw-client-profile (PswClientProfileScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-client-profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PswClientProfileScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswclientprofile-screen").should("be.visible");
  cy.getCy("pswclientprofile-title").should("be.visible");
  cy.getCy("pswclientprofile-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PswClientProfileScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_client_profile");
  
  cy.task("log", "✅ PROGRESS: - Verified PswClientProfileScreen successfully!\n");

  });
});
