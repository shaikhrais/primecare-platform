// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - provider_performance_dashboard", () => {
  it("opens and verifies screen provider_performance_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Provider Performance Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Provider Performance Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("providerperformancedashboard-screen").should("be.visible");
  cy.getCy("providerperformancedashboard-title").should("be.visible");
  cy.getCy("providerperformancedashboard-content").should("be.visible");
  cy.getCy("provider-dashboard-btn-refresh").should("be.visible");
  cy.getCy("provider-dashboard-error-message").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Provider Performance Dashboard...");
  cy.waitAndSee();
  cy.screenshot("provider_performance_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Provider Performance Dashboard successfully!\n");

  });
});
