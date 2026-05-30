// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_messages", () => {
  it("opens and verifies screen psw_messages", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/messages (PswMessagesScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/messages");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PswMessagesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmessages-screen").should("be.visible");
  cy.getCy("pswmessages-title").should("be.visible");
  cy.getCy("pswmessages-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PswMessagesScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_messages");
  
  cy.task("log", "✅ PROGRESS: - Verified PswMessagesScreen successfully!\n");

  });
});
