// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_care_plan_review", () => {
  it("opens and verifies screen rn_care_plan_review", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/rn-care-plan-review (RnCarePlanReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-care-plan-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RnCarePlanReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncareplanreview-screen").should("be.visible");
  cy.getCy("rncareplanreview-title").should("be.visible");
  cy.getCy("rncareplanreview-content").should("be.visible");
  cy.getCy("rn-dashboard-patient-status").should("be.visible");
  cy.getCy("rn-dashboard-compliance-audit").should("be.visible");
  cy.getCy("rn-dashboard-medication-records").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RnCarePlanReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_care_plan_review");
  
  cy.task("log", "✅ PROGRESS: - Verified RnCarePlanReviewScreen successfully!\n");

  });
});
