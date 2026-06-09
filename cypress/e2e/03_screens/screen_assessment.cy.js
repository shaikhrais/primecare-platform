// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - assessment", () => {
  it("opens and verifies screen assessment", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Assessment)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Assessment...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("assessment-screen").should("be.visible");
  cy.getCy("assessment-title").should("be.visible");
  cy.getCy("assessment-content").should("be.visible");
  cy.getCy("assessment-btn-run-scan").should("be.visible");
  cy.getCy("assessment-btn-trigger-action").should("be.visible");
  cy.getCy("assessment-btn-refresh-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Assessment...");
  cy.waitAndSee();
  cy.screenshot("assessment");
  
  cy.task("log", "✅ PROGRESS: - Verified Assessment successfully!\n");

  });
});
