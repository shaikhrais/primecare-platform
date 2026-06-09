// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - no_access", () => {
  it("opens and verifies screen no_access", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (No Access)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for No Access...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("noaccess-screen").should("be.visible");
  cy.getCy("noaccess-title").should("be.visible");
  cy.getCy("noaccess-content").should("be.visible");
  cy.getCy("no-access-btn-go-back").should("be.visible");
  cy.getCy("no-access-btn-request-permissions").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for No Access...");
  cy.waitAndSee();
  cy.screenshot("no_access");
  
  cy.task("log", "✅ PROGRESS: - Verified No Access successfully!\n");

  });
});
