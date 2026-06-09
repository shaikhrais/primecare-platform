// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - governance_hud", () => {
  it("opens and verifies screen governance_hud", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /governance/hud (Governance Hud)...");
  cy.visitWithSemantics("/governance/hud");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Governance Hud...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governancehud-screen").should("be.visible");
  cy.getCy("governancehud-title").should("be.visible");
  cy.getCy("governancehud-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-submit-feedback").should("be.visible");
  cy.getCy("gov-dashboard-btn-mark-action-complete").should("be.visible");
  cy.getCy("gov-dashboard-btn-view-risk-mitigation").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Governance Hud...");
  cy.waitAndSee();
  cy.screenshot("governance_hud");
  
  cy.task("log", "✅ PROGRESS: - Verified Governance Hud successfully!\n");

  });
});
