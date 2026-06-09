// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - security_sentinel", () => {
  it("opens and verifies screen security_sentinel", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /governance/security (Security Sentinel)...");
  cy.visitWithSemantics("/governance/security");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Security Sentinel...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("securitysentinel-screen").should("be.visible");
  cy.getCy("securitysentinel-title").should("be.visible");
  cy.getCy("securitysentinel-content").should("be.visible");
  cy.getCy("security-alerts-widget").should("be.visible");
  cy.getCy("incident-summary-widget").should("be.visible");
  cy.getCy("security-status-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Security Sentinel...");
  cy.waitAndSee();
  cy.screenshot("security_sentinel");
  
  cy.task("log", "✅ PROGRESS: - Verified Security Sentinel successfully!\n");

  });
});
