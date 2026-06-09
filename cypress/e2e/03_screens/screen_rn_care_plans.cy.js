// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_care_plans", () => {
  it("opens and verifies screen rn_care_plans", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/rn-care-plans (RnCarePlansScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-care-plans");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RnCarePlansScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncareplans-screen").should("be.visible");
  cy.getCy("rncareplans-title").should("be.visible");
  cy.getCy("rncareplans-content").should("be.visible");
  cy.getCy("rn-dashboard-careplan-overview").should("be.visible");
  cy.getCy("rn-dashboard-patient-demographics").should("be.visible");
  cy.getCy("rn-dashboard-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RnCarePlansScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_care_plans");
  
  cy.task("log", "✅ PROGRESS: - Verified RnCarePlansScreen successfully!\n");

  });
});
