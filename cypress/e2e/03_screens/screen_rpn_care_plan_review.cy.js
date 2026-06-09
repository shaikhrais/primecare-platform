// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_care_plan_review", () => {
  it("opens and verifies screen rpn_care_plan_review", () => {
    cy.loginAsRole("rpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rpn/rpn-care-plan-review (RpnCarePlanReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-care-plan-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RpnCarePlanReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpncareplanreview-screen").should("be.visible");
  cy.getCy("rpncareplanreview-title").should("be.visible");
  cy.getCy("rpncareplanreview-content").should("be.visible");
  cy.getCy("rpn-dashboard-btn-view-metrics").should("be.visible");
  cy.getCy("rpn-dashboard-btn-audit-compliance").should("be.visible");
  cy.getCy("rpn-dashboard-btn-view-kpis").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RpnCarePlanReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_care_plan_review");
  
  cy.task("log", "✅ PROGRESS: - Verified RpnCarePlanReviewScreen successfully!\n");

  });
});
