// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - service_issue", () => {
  it("opens and verifies screen service_issue", () => {
    cy.loginAsRole("ops_manager");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/service-issue (ServiceIssueScreen)...");
  cy.visitWithSemantics("/management/service-issue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ServiceIssueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("serviceissue-screen").should("be.visible");
  cy.getCy("serviceissue-title").should("be.visible");
  cy.getCy("serviceissue-content").should("be.visible");
  cy.getCy("opsdashboard-btn-generate-report").should("be.visible");
  cy.getCy("opsdashboard-btn-view-compliance").should("be.visible");
  cy.getCy("opsdashboard-btn-track-budget").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ServiceIssueScreen...");
  cy.waitAndSee();
  cy.screenshot("service_issue");
  
  cy.task("log", "✅ PROGRESS: - Verified ServiceIssueScreen successfully!\n");

  });
});
