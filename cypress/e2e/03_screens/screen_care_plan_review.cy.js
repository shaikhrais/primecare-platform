// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - care_plan_review", () => {
  it("opens and verifies screen care_plan_review", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/care-plan-review (CarePlanReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/care-plan-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CarePlanReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("careplanreview-screen").should("be.visible");
  cy.getCy("careplanreview-title").should("be.visible");
  cy.getCy("careplanreview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CarePlanReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("care_plan_review");
  
  cy.task("log", "✅ PROGRESS: - Verified CarePlanReviewScreen successfully!\n");

  });
});
