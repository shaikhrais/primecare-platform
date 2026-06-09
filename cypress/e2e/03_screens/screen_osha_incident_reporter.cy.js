// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - osha_incident_reporter", () => {
  it("opens and verifies screen osha_incident_reporter", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Osha Incident Reporter)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Osha Incident Reporter...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("oshaincidentreporter-screen").should("be.visible");
  cy.getCy("oshaincidentreporter-title").should("be.visible");
  cy.getCy("oshaincidentreporter-content").should("be.visible");
  cy.getCy("osha-incident-list").should("be.visible");
  cy.getCy("osha-refresh-button").should("be.visible");
  cy.getCy("osha-file-report-button").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Osha Incident Reporter...");
  cy.waitAndSee();
  cy.screenshot("osha_incident_reporter");
  
  cy.task("log", "✅ PROGRESS: - Verified Osha Incident Reporter successfully!\n");

  });
});
