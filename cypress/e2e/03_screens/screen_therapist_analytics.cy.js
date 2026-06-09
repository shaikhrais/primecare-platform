// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - therapist_analytics", () => {
  it("opens and verifies screen therapist_analytics", () => {
    cy.loginAsRole("therapist");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/therapist/analytics (Therapist Analytics)...");
  cy.visitWithSemantics("/offices/clinical/roles/therapist/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Therapist Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapistanalytics-screen").should("be.visible");
  cy.getCy("therapistanalytics-title").should("be.visible");
  cy.getCy("therapistanalytics-content").should("be.visible");
  cy.getCy("therapist-dashboard-caseload").should("be.visible");
  cy.getCy("therapist-dashboard-progress").should("be.visible");
  cy.getCy("therapist-dashboard-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Therapist Analytics...");
  cy.waitAndSee();
  cy.screenshot("therapist_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified Therapist Analytics successfully!\n");

  });
});
