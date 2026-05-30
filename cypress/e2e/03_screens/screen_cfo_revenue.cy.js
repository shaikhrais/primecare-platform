// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_revenue", () => {
  it("opens and verifies screen cfo_revenue", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/cfo-revenue (CfoRevenueScreen)...");
  cy.visitWithSemantics("/executive/cfo-revenue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CfoRevenueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cforevenue-screen").should("be.visible");
  cy.getCy("cforevenue-title").should("be.visible");
  cy.getCy("cforevenue-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CfoRevenueScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_revenue");
  
  cy.task("log", "✅ PROGRESS: - Verified CfoRevenueScreen successfully!\n");

  });
});
