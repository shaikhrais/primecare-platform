// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_applicants", () => {
  it("opens and verifies screen hr_hiring_applicants", () => {
    cy.loginAsRole("hr_hiring");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/hr_hiring/applicants (HrHiringApplicantsScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/applicants");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrHiringApplicantsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringapplicants-screen").should("be.visible");
  cy.getCy("hrhiringapplicants-title").should("be.visible");
  cy.getCy("hrhiringapplicants-content").should("be.visible");
  cy.getCy("recruitment-kpi-chart").should("be.visible");
  cy.getCy("candidate-pipeline-visualization").should("be.visible");
  cy.getCy("diversity-metrics-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrHiringApplicantsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_applicants");
  
  cy.task("log", "✅ PROGRESS: - Verified HrHiringApplicantsScreen successfully!\n");

  });
});
