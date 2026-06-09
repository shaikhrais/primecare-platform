// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_marketing_brand_assets", () => {
  it("opens and verifies screen head_of_marketing_brand_assets", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Head Of Marketing Brand Assets)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Head Of Marketing Brand Assets...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingbrandassets-screen").should("be.visible");
  cy.getCy("headofmarketingbrandassets-title").should("be.visible");
  cy.getCy("headofmarketingbrandassets-content").should("be.visible");
  cy.getCy("brandasset-overview").should("be.visible");
  cy.getCy("performance-metrics-chart").should("be.visible");
  cy.getCy("approval-notifications").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Head Of Marketing Brand Assets...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_brand_assets");
  
  cy.task("log", "✅ PROGRESS: - Verified Head Of Marketing Brand Assets successfully!\n");

  });
});
