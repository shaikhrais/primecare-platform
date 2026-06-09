// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - home_care_plan", () => {
  it("opens and verifies screen home_care_plan", () => {
    cy.loginAsRole("rmt");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rmt/home-care-plan (HomeCarePlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/home-care-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HomeCarePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("homecareplan-screen").should("be.visible");
  cy.getCy("homecareplan-title").should("be.visible");
  cy.getCy("homecareplan-content").should("be.visible");
  cy.getCy("homecareplan-btn-view-client").should("be.visible");
  cy.getCy("homecareplan-btn-schedule-appointment").should("be.visible");
  cy.getCy("homecareplan-btn-update-treatment").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HomeCarePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("home_care_plan");
  
  cy.task("log", "✅ PROGRESS: - Verified HomeCarePlanScreen successfully!\n");

  });
});
