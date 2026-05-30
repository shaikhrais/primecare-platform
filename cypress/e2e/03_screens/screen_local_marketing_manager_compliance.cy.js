// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - local_marketing_manager_compliance", () => {
  it("opens and verifies screen local_marketing_manager_compliance", () => {
    cy.loginAsRole("local_marketing");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/local-marketing-manager-compliance (LocalMarketingManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for LocalMarketingManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagercompliance-screen").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-title").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for LocalMarketingManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified LocalMarketingManagerComplianceScreen successfully!\n");

  });
});
