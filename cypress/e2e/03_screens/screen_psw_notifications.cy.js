// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_notifications", () => {
  it("opens and verifies screen psw_notifications", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Psw Notifications)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Psw Notifications...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswnotifications-screen").should("be.visible");
  cy.getCy("pswnotifications-title").should("be.visible");
  cy.getCy("pswnotifications-content").should("be.visible");
  cy.getCy("psw_notifications-list").should("be.visible");
  cy.getCy("psw_notifications-dismiss").should("be.visible");
  cy.getCy("psw_notifications-settings").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Psw Notifications...");
  cy.waitAndSee();
  cy.screenshot("psw_notifications");
  
  cy.task("log", "✅ PROGRESS: - Verified Psw Notifications successfully!\n");

  });
});
