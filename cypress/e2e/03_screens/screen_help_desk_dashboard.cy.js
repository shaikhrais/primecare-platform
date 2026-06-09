// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - help_desk_dashboard", () => {
  it("opens and verifies screen help_desk_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to SupportRoutes.helpDeskDashboard (Help Desk Dashboard)...");
  cy.visitWithSemantics("SupportRoutes.helpDeskDashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Help Desk Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("helpdeskdashboard-screen").should("be.visible");
  cy.getCy("helpdeskdashboard-title").should("be.visible");
  cy.getCy("helpdeskdashboard-content").should("be.visible");
  cy.getCy("helpdesk-dashboard-ticket-status").should("be.visible");
  cy.getCy("helpdesk-dashboard-resolution-time").should("be.visible");
  cy.getCy("helpdesk-dashboard-user-satisfaction").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Help Desk Dashboard...");
  cy.waitAndSee();
  cy.screenshot("help_desk_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Help Desk Dashboard successfully!\n");

  });
});
