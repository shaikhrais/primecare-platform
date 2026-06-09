// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_messaging", () => {
  it("opens and verifies screen psw_messaging", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Psw Messaging)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Psw Messaging...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmessaging-screen").should("be.visible");
  cy.getCy("pswmessaging-title").should("be.visible");
  cy.getCy("pswmessaging-content").should("be.visible");
  cy.getCy("psw-messaging-btn-send").should("be.visible");
  cy.getCy("psw-messaging-btn-refresh").should("be.visible");
  cy.getCy("psw-messaging-notification-panel").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Psw Messaging...");
  cy.waitAndSee();
  cy.screenshot("psw_messaging");
  
  cy.task("log", "✅ PROGRESS: - Verified Psw Messaging successfully!\n");

  });
});
