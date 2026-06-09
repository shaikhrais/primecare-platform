// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - security_hub", () => {
  it("opens and verifies screen security_hub", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /governance/device-security (Security Hub)...");
  cy.visitWithSemantics("/governance/device-security");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Security Hub...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("securityhub-screen").should("be.visible");
  cy.getCy("securityhub-title").should("be.visible");
  cy.getCy("securityhub-content").should("be.visible");
  cy.getCy("securityhub-alerts-overview").should("be.visible");
  cy.getCy("securityhub-recent-incidents").should("be.visible");
  cy.getCy("securityhub-user-access-summary").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Security Hub...");
  cy.waitAndSee();
  cy.screenshot("security_hub");
  
  cy.task("log", "✅ PROGRESS: - Verified Security Hub successfully!\n");

  });
});
