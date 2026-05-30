// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - communication", () => {
  it("opens and verifies screen communication", () => {
    cy.loginAsRole("customer_support");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/communication (CommunicationScreen)...");
  cy.visitWithSemantics("/staff/communication");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CommunicationScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communication-screen").should("be.visible");
  cy.getCy("communication-title").should("be.visible");
  cy.getCy("communication-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CommunicationScreen...");
  cy.waitAndSee();
  cy.screenshot("communication");
  
  cy.task("log", "✅ PROGRESS: - Verified CommunicationScreen successfully!\n");

  });
});
