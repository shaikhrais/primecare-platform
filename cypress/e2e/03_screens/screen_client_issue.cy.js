// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - client_issue", () => {
  it("opens and verifies screen client_issue", () => {
    cy.loginAsRole("customer_support");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/client-issue (ClientIssueScreen)...");
  cy.visitWithSemantics("/staff/client-issue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ClientIssueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientissue-screen").should("be.visible");
  cy.getCy("clientissue-title").should("be.visible");
  cy.getCy("clientissue-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ClientIssueScreen...");
  cy.waitAndSee();
  cy.screenshot("client_issue");
  
  cy.task("log", "✅ PROGRESS: - Verified ClientIssueScreen successfully!\n");

  });
});
