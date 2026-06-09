// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_my_clients", () => {
  it("opens and verifies screen psw_my_clients", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Psw My Clients)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Psw My Clients...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmyclients-screen").should("be.visible");
  cy.getCy("pswmyclients-title").should("be.visible");
  cy.getCy("pswmyclients-content").should("be.visible");
  cy.getCy("clientlist-view").should("be.visible");
  cy.getCy("clientform-add").should("be.visible");
  cy.getCy("clientform-edit").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Psw My Clients...");
  cy.waitAndSee();
  cy.screenshot("psw_my_clients");
  
  cy.task("log", "✅ PROGRESS: - Verified Psw My Clients successfully!\n");

  });
});
