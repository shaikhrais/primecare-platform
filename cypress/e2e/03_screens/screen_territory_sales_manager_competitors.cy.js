// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_sales_manager_competitors", () => {
  it("opens and verifies screen territory_sales_manager_competitors", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Territory Sales Manager Competitors)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Sales Manager Competitors...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagercompetitors-screen").should("be.visible");
  cy.getCy("territorysalesmanagercompetitors-title").should("be.visible");
  cy.getCy("territorysalesmanagercompetitors-content").should("be.visible");
  cy.getCy("competitor-activity-feed").should("be.visible");
  cy.getCy("competitor-profile-editor").should("be.visible");
  cy.getCy("generate-report-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Sales Manager Competitors...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_competitors");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Sales Manager Competitors successfully!\n");

  });
});
