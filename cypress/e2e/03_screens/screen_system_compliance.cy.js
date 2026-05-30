// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - system_compliance", () => {
  it("opens and verifies screen system_compliance", () => {
    cy.loginAsRole("system_verification");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/system-compliance (SystemComplianceScreen)...");
  cy.visitWithSemantics("/common/system-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SystemComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemcompliance-screen").should("be.visible");
  cy.getCy("systemcompliance-title").should("be.visible");
  cy.getCy("systemcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SystemComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("system_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified SystemComplianceScreen successfully!\n");

  });
});
