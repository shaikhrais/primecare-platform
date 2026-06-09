// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - assessments", () => {
  it("opens and verifies screen assessments", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Assessments)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Assessments...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("assessments-screen").should("be.visible");
  cy.getCy("assessments-title").should("be.visible");
  cy.getCy("assessments-content").should("be.visible");
  cy.getCy("assessments-loading-indicator").should("be.visible");
  cy.getCy("assessments-error-message").should("be.visible");
  cy.getCy("assessments-list").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Assessments...");
  cy.waitAndSee();
  cy.screenshot("assessments");
  
  cy.task("log", "✅ PROGRESS: - Verified Assessments successfully!\n");

  });
});
