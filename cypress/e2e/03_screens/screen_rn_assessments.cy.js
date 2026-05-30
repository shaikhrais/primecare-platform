// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_assessments", () => {
  it("opens and verifies screen rn_assessments", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/rn-assessments (RnAssessmentsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-assessments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RnAssessmentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnassessments-screen").should("be.visible");
  cy.getCy("rnassessments-title").should("be.visible");
  cy.getCy("rnassessments-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RnAssessmentsScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_assessments");
  
  cy.task("log", "✅ PROGRESS: - Verified RnAssessmentsScreen successfully!\n");

  });
});
