// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - local_marketing_manager_budget", () => {
  it("opens and verifies screen local_marketing_manager_budget", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Local Marketing Manager Budget)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Local Marketing Manager Budget...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerbudget-screen").should("be.visible");
  cy.getCy("localmarketingmanagerbudget-title").should("be.visible");
  cy.getCy("localmarketingmanagerbudget-content").should("be.visible");
  cy.getCy("budget-overview").should("be.visible");
  cy.getCy("campaign-performance").should("be.visible");
  cy.getCy("budget-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Local Marketing Manager Budget...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_budget");
  
  cy.task("log", "✅ PROGRESS: - Verified Local Marketing Manager Budget successfully!\n");

  });
});
