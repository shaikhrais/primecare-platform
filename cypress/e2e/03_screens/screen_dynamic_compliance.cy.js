// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - dynamic_compliance", () => {
  it("opens and verifies screen dynamic_compliance", () => {
    cy.loginAsRole("dynamic");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/dynamic-compliance (DynamicScreenComplianceScreen)...");
  cy.visitWithSemantics("/common/dynamic-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for DynamicScreenComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamiccompliance-screen").should("be.visible");
  cy.getCy("dynamiccompliance-title").should("be.visible");
  cy.getCy("dynamiccompliance-content").should("be.visible");
  cy.getCy("dynamic-compliance-btn-execute-scan").should("be.visible");
  cy.getCy("dynamic-compliance-btn-trigger-action").should("be.visible");
  cy.getCy("dynamic-compliance-btn-refresh-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for DynamicScreenComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("dynamic_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified DynamicScreenComplianceScreen successfully!\n");

  });
});
