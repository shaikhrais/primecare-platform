// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_reports", () => {
  it("opens and verifies screen training_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Training Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingreports-screen").should("be.visible");
  cy.getCy("trainingreports-title").should("be.visible");
  cy.getCy("trainingreports-content").should("be.visible");
  cy.getCy("training-reports-loading").should("be.visible");
  cy.getCy("training-reports-error").should("be.visible");
  cy.getCy("training-reports-summary").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Reports...");
  cy.waitAndSee();
  cy.screenshot("training_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Reports successfully!\n");

  });
});
