// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - partnership_manager_outreach", () => {
  it("opens and verifies screen partnership_manager_outreach", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/partnership_manager/outreach (Partnership Manager Outreach)...");
  cy.visitWithSemantics("/offices/business_development/roles/partnership_manager/outreach");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Partnership Manager Outreach...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanageroutreach-screen").should("be.visible");
  cy.getCy("partnershipmanageroutreach-title").should("be.visible");
  cy.getCy("partnershipmanageroutreach-content").should("be.visible");
  cy.getCy("partnerships-overview-card").should("be.visible");
  cy.getCy("engagement-metrics-chart").should("be.visible");
  cy.getCy("task-notification-list").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Partnership Manager Outreach...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_outreach");
  
  cy.task("log", "✅ PROGRESS: - Verified Partnership Manager Outreach successfully!\n");

  });
});
