// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_marketing_compliance", () => {
  it("opens and verifies screen head_of_marketing_compliance", () => {
    cy.loginAsRole("marketing");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/head-of-marketing-compliance (HeadOfMarketingComplianceScreen)...");
  cy.visitWithSemantics("/management/head-of-marketing-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HeadOfMarketingComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingcompliance-screen").should("be.visible");
  cy.getCy("headofmarketingcompliance-title").should("be.visible");
  cy.getCy("headofmarketingcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HeadOfMarketingComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified HeadOfMarketingComplianceScreen successfully!\n");

  });
});
