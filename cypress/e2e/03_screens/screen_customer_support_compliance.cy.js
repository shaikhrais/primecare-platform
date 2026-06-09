// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - customer_support_compliance", () => {
  it("opens and verifies screen customer_support_compliance", () => {
    cy.loginAsRole("customer_support");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/customer-support-compliance (CustomerSupportComplianceScreen)...");
  cy.visitWithSemantics("/common/customer-support-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CustomerSupportComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportcompliance-screen").should("be.visible");
  cy.getCy("customersupportcompliance-title").should("be.visible");
  cy.getCy("customersupportcompliance-content").should("be.visible");
  cy.getCy("customer-support-btn-respond").should("be.visible");
  cy.getCy("customer-support-btn-audit").should("be.visible");
  cy.getCy("customer-support-btn-update-security").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CustomerSupportComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("customer_support_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified CustomerSupportComplianceScreen successfully!\n");

  });
});
