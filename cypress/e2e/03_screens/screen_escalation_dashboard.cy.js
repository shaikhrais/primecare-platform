// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - escalation_dashboard", () => {
  it("opens and verifies screen escalation_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to SupportRoutes.escalationDashboard (Escalation Dashboard)...");
  cy.visitWithSemantics("SupportRoutes.escalationDashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Escalation Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("escalationdashboard-screen").should("be.visible");
  cy.getCy("escalationdashboard-title").should("be.visible");
  cy.getCy("escalationdashboard-content").should("be.visible");
  cy.getCy("escalation-dashboard-status").should("be.visible");
  cy.getCy("escalation-dashboard-metrics").should("be.visible");
  cy.getCy("escalation-dashboard-trends").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Escalation Dashboard...");
  cy.waitAndSee();
  cy.screenshot("escalation_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Escalation Dashboard successfully!\n");

  });
});
