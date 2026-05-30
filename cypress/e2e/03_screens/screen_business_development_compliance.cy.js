// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - business_development_compliance", () => {
  it("opens and verifies screen business_development_compliance", () => {
    cy.loginAsRole("bus_dev");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/business-development-compliance (BusinessDevelopmentComplianceScreen)...");
  cy.visitWithSemantics("/common/business-development-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for BusinessDevelopmentComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentcompliance-screen").should("be.visible");
  cy.getCy("businessdevelopmentcompliance-title").should("be.visible");
  cy.getCy("businessdevelopmentcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for BusinessDevelopmentComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("business_development_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified BusinessDevelopmentComplianceScreen successfully!\n");

  });
});
