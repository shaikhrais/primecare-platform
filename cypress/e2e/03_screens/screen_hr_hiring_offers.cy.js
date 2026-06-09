// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_offers", () => {
  it("opens and verifies screen hr_hiring_offers", () => {
    cy.loginAsRole("hr_hiring");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/hr_hiring/offers (HrHiringOffersScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/offers");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrHiringOffersScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringoffers-screen").should("be.visible");
  cy.getCy("hrhiringoffers-title").should("be.visible");
  cy.getCy("hrhiringoffers-content").should("be.visible");
  cy.getCy("recruitment-kpi-chart").should("be.visible");
  cy.getCy("candidate-pipeline-chart").should("be.visible");
  cy.getCy("diversity-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrHiringOffersScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_offers");
  
  cy.task("log", "✅ PROGRESS: - Verified HrHiringOffersScreen successfully!\n");

  });
});
