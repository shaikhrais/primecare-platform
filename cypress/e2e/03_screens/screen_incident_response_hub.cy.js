// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - incident_response_hub", () => {
  it("opens and verifies screen incident_response_hub", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Incident Response Hub)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Incident Response Hub...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentresponsehub-screen").should("be.visible");
  cy.getCy("incidentresponsehub-title").should("be.visible");
  cy.getCy("incidentresponsehub-content").should("be.visible");
  cy.getCy("incident-response-btn-refresh").should("be.visible");
  cy.getCy("incident-response-btn-declare").should("be.visible");
  cy.getCy("incident-response-btn-join-war-room").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Incident Response Hub...");
  cy.waitAndSee();
  cy.screenshot("incident_response_hub");
  
  cy.task("log", "✅ PROGRESS: - Verified Incident Response Hub successfully!\n");

  });
});
