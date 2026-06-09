// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - service_quality", () => {
  it("opens and verifies screen service_quality", () => {
    cy.loginAsRole("coo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/service-quality (ServiceQualityScreen)...");
  cy.visitWithSemantics("/executive/service-quality");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ServiceQualityScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("servicequality-screen").should("be.visible");
  cy.getCy("servicequality-title").should("be.visible");
  cy.getCy("servicequality-content").should("be.visible");
  cy.getCy("c-dashboard-btn-refresh").should("be.visible");
  cy.getCy("c-dashboard-btn-export").should("be.visible");
  cy.getCy("c-dashboard-btn-view-details").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ServiceQualityScreen...");
  cy.waitAndSee();
  cy.screenshot("service_quality");
  
  cy.task("log", "✅ PROGRESS: - Verified ServiceQualityScreen successfully!\n");

  });
});
