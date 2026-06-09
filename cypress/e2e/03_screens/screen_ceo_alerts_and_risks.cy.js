// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_alerts_and_risks", () => {
  it("opens and verifies screen ceo_alerts_and_risks", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/ceo/alerts-and-risks (Ceo Alerts And Risks)...");
  cy.visitWithSemantics("/offices/corporate/roles/ceo/alerts-and-risks");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Alerts And Risks...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ceoalertsandrisks-screen").should("be.visible");
  cy.getCy("ceoalertsandrisks-title").should("be.visible");
  cy.getCy("ceoalertsandrisks-content").should("be.visible");
  cy.getCy("ceo-alerts-btn-respond").should("be.visible");
  cy.getCy("ceo-feedback-btn-submit").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Alerts And Risks...");
  cy.waitAndSee();
  cy.screenshot("ceo_alerts_and_risks");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Alerts And Risks successfully!\n");

  });
});
