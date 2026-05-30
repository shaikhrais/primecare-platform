// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - assessment", () => {
  it("opens and verifies screen assessment", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/physiotherapist/assessment (AssessmentScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/assessment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for AssessmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("assessment-screen").should("be.visible");
  cy.getCy("assessment-title").should("be.visible");
  cy.getCy("assessment-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for AssessmentScreen...");
  cy.waitAndSee();
  cy.screenshot("assessment");
  
  cy.task("log", "✅ PROGRESS: - Verified AssessmentScreen successfully!\n");

  });
});
