// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - app_notification", () => {
  it("opens and verifies screen app_notification", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (App Notification)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for App Notification...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("appnotification-screen").should("be.visible");
  cy.getCy("appnotification-title").should("be.visible");
  cy.getCy("appnotification-content").should("be.visible");
  cy.getCy("iot-notification-list").should("be.visible");
  cy.getCy("alert-dispatch-btn").should("be.visible");
  cy.getCy("resolve-event-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for App Notification...");
  cy.waitAndSee();
  cy.screenshot("app_notification");
  
  cy.task("log", "✅ PROGRESS: - Verified App Notification successfully!\n");

  });
});
