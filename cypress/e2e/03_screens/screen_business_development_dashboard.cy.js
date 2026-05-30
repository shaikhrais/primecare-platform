// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - business_development_dashboard", () => {
  it("opens and verifies screen business_development_dashboard", () => {
    cy.loginAsRole("bus_dev");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/business-development-dashboard (BusinessDevelopmentDashboardScreen)...");
  cy.visitWithSemantics("/common/business-development-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for BusinessDevelopmentDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentdashboard-screen").should("be.visible");
  cy.getCy("businessdevelopmentdashboard-title").should("be.visible");
  cy.getCy("businessdevelopmentdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for BusinessDevelopmentDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("business_development_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified BusinessDevelopmentDashboardScreen successfully!\n");

  });
});
