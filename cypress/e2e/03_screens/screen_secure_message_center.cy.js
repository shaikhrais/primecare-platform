// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - secure_message_center", () => {
  it("opens and verifies screen secure_message_center", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Secure Message Center)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Secure Message Center...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("securemessagecenter-screen").should("be.visible");
  cy.getCy("securemessagecenter-title").should("be.visible");
  cy.getCy("securemessagecenter-content").should("be.visible");
  cy.getCy("message-center-btn-refresh").should("be.visible");
  cy.getCy("message-center-btn-compose").should("be.visible");
  cy.getCy("message-center-btn-reply").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Secure Message Center...");
  cy.waitAndSee();
  cy.screenshot("secure_message_center");
  
  cy.task("log", "✅ PROGRESS: - Verified Secure Message Center successfully!\n");

  });
});
