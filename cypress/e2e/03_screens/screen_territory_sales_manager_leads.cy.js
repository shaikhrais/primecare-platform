// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_sales_manager_leads", () => {
  it("opens and verifies screen territory_sales_manager_leads", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Territory Sales Manager Leads)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Sales Manager Leads...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerleads-screen").should("be.visible");
  cy.getCy("territorysalesmanagerleads-title").should("be.visible");
  cy.getCy("territorysalesmanagerleads-content").should("be.visible");
  cy.getCy("lead-overview-card").should("be.visible");
  cy.getCy("btn-update-lead").should("be.visible");
  cy.getCy("btn-communicate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Sales Manager Leads...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_leads");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Sales Manager Leads successfully!\n");

  });
});
