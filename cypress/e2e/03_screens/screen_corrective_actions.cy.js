// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - corrective_actions", () => {
  it("opens and verifies screen corrective_actions", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/compliance_manager/corrective-actions (Corrective Actions)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/corrective-actions");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Corrective Actions...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("correctiveactions-screen").should("be.visible");
  cy.getCy("correctiveactions-title").should("be.visible");
  cy.getCy("correctiveactions-content").should("be.visible");
  cy.getCy("corrective-actions-overview").should("be.visible");
  cy.getCy("trend-analysis-chart").should("be.visible");
  cy.getCy("notifications-list").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Corrective Actions...");
  cy.waitAndSee();
  cy.screenshot("corrective_actions");
  
  cy.task("log", "✅ PROGRESS: - Verified Corrective Actions successfully!\n");

  });
});
