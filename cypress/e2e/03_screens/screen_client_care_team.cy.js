// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - client_care_team", () => {
  it("opens and verifies screen client_care_team", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Client Care Team)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Client Care Team...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientcareteam-screen").should("be.visible");
  cy.getCy("clientcareteam-title").should("be.visible");
  cy.getCy("clientcareteam-content").should("be.visible");
  cy.getCy("clientcare-btn-respond").should("be.visible");
  cy.getCy("clientcare-btn-document").should("be.visible");
  cy.getCy("clientcare-btn-analyze").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Client Care Team...");
  cy.waitAndSee();
  cy.screenshot("client_care_team");
  
  cy.task("log", "✅ PROGRESS: - Verified Client Care Team successfully!\n");

  });
});
