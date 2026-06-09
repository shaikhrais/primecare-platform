// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - client_dashboard", () => {
  it("opens and verifies screen client_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Client Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Client Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientdashboard-screen").should("be.visible");
  cy.getCy("clientdashboard-title").should("be.visible");
  cy.getCy("clientdashboard-content").should("be.visible");
  cy.getCy("client-dashboard-btn-refresh").should("be.visible");
  cy.getCy("client-dashboard-btn-view-reports").should("be.visible");
  cy.getCy("client-dashboard-btn-report-issue").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Client Dashboard...");
  cy.waitAndSee();
  cy.screenshot("client_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Client Dashboard successfully!\n");

  });
});
