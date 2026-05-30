// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - system_verification_compliance", () => {
  it("opens and verifies screen system_verification_compliance", () => {
    cy.loginAsRole("system_verification");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/system-verification-compliance (SystemVerificationComplianceScreen)...");
  cy.visitWithSemantics("/common/system-verification-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SystemVerificationComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationcompliance-screen").should("be.visible");
  cy.getCy("systemverificationcompliance-title").should("be.visible");
  cy.getCy("systemverificationcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SystemVerificationComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("system_verification_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified SystemVerificationComplianceScreen successfully!\n");

  });
});
