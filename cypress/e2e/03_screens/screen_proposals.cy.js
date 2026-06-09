// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - proposals", () => {
  it("opens and verifies screen proposals", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /proposals (Proposals)...");
  cy.visitWithSemantics("/proposals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Proposals...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("proposals-screen").should("be.visible");
  cy.getCy("proposals-title").should("be.visible");
  cy.getCy("proposals-content").should("be.visible");
  cy.getCy("proposals-btn-create").should("be.visible");
  cy.getCy("proposals-btn-edit").should("be.visible");
  cy.getCy("proposals-btn-submit").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Proposals...");
  cy.waitAndSee();
  cy.screenshot("proposals");
  
  cy.task("log", "✅ PROGRESS: - Verified Proposals successfully!\n");

  });
});
