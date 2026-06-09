// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - response_bot_audit", () => {
  it("opens and verifies screen response_bot_audit", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Response Bot Audit)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Response Bot Audit...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("responsebotaudit-screen").should("be.visible");
  cy.getCy("responsebotaudit-title").should("be.visible");
  cy.getCy("responsebotaudit-content").should("be.visible");
  cy.getCy("responsebot-btn-approve").should("be.visible");
  cy.getCy("responsebot-btn-flag").should("be.visible");
  cy.getCy("responsebot-input-search").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Response Bot Audit...");
  cy.waitAndSee();
  cy.screenshot("response_bot_audit");
  
  cy.task("log", "✅ PROGRESS: - Verified Response Bot Audit successfully!\n");

  });
});
