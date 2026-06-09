// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - grant_funding_allocation", () => {
  it("opens and verifies screen grant_funding_allocation", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Grant Funding Allocation)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Grant Funding Allocation...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("grantfundingallocation-screen").should("be.visible");
  cy.getCy("grantfundingallocation-title").should("be.visible");
  cy.getCy("grantfundingallocation-content").should("be.visible");
  cy.getCy("funding-overview-card").should("be.visible");
  cy.getCy("funding-allocation-chart").should("be.visible");
  cy.getCy("funding-status-table").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Grant Funding Allocation...");
  cy.waitAndSee();
  cy.screenshot("grant_funding_allocation");
  
  cy.task("log", "✅ PROGRESS: - Verified Grant Funding Allocation successfully!\n");

  });
});
