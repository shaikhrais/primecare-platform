// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_issue_tracking", () => {
  it("opens and verifies screen cto_issue_tracking", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cto/issue-tracking (Cto Issue Tracking)...");
  cy.visitWithSemantics("/offices/corporate/roles/cto/issue-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cto Issue Tracking...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctoissuetracking-screen").should("be.visible");
  cy.getCy("ctoissuetracking-title").should("be.visible");
  cy.getCy("ctoissuetracking-content").should("be.visible");
  cy.getCy("issue-status-overview").should("be.visible");
  cy.getCy("issue-notification-widget").should("be.visible");
  cy.getCy("issue-analytics-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cto Issue Tracking...");
  cy.waitAndSee();
  cy.screenshot("cto_issue_tracking");
  
  cy.task("log", "✅ PROGRESS: - Verified Cto Issue Tracking successfully!\n");

  });
});
