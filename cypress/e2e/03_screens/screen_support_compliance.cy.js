// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - support_compliance", () => {
  it("opens and verifies screen support_compliance", () => {
    cy.loginAsRole("customer_support");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/support-compliance (SupportComplianceScreen)...");
  cy.visitWithSemantics("/common/support-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SupportComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportcompliance-screen").should("be.visible");
  cy.getCy("supportcompliance-title").should("be.visible");
  cy.getCy("supportcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SupportComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("support_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified SupportComplianceScreen successfully!\n");

  });
});
