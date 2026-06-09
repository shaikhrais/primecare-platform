// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - security_incident_logger", () => {
  it("opens and verifies screen security_incident_logger", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Security Incident Logger)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Security Incident Logger...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("securityincidentlogger-screen").should("be.visible");
  cy.getCy("securityincidentlogger-title").should("be.visible");
  cy.getCy("securityincidentlogger-content").should("be.visible");
  cy.getCy("incident-list").should("be.visible");
  cy.getCy("btn-refresh-incidents").should("be.visible");
  cy.getCy("btn-log-incident").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Security Incident Logger...");
  cy.waitAndSee();
  cy.screenshot("security_incident_logger");
  
  cy.task("log", "✅ PROGRESS: - Verified Security Incident Logger successfully!\n");

  });
});
