// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - incident_review", () => {
  it("opens and verifies screen incident_review", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/incident-review (IncidentReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/incident-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for IncidentReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentreview-screen").should("be.visible");
  cy.getCy("incidentreview-title").should("be.visible");
  cy.getCy("incidentreview-content").should("be.visible");
  cy.getCy("incidentreview-btn-view-records").should("be.visible");
  cy.getCy("incidentreview-btn-log-medication").should("be.visible");
  cy.getCy("incidentreview-btn-track-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for IncidentReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("incident_review");
  
  cy.task("log", "✅ PROGRESS: - Verified IncidentReviewScreen successfully!\n");

  });
});
