// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - security_incident", () => {
  it("opens and verifies screen security_incident", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Security Incident)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Security Incident...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("securityincident-screen").should("be.visible");
  cy.getCy("securityincident-title").should("be.visible");
  cy.getCy("securityincident-content").should("be.visible");
  cy.getCy("security-incident-btn-submit").should("be.visible");
  cy.getCy("security-incident-btn-update").should("be.visible");
  cy.getCy("security-incident-filter").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Security Incident...");
  cy.waitAndSee();
  cy.screenshot("security_incident");
  
  cy.task("log", "✅ PROGRESS: - Verified Security Incident successfully!\n");

  });
});
