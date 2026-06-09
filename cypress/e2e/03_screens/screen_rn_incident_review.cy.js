// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_incident_review", () => {
  it("opens and verifies screen rn_incident_review", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/rn-incident-review (RnIncidentReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-incident-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RnIncidentReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnincidentreview-screen").should("be.visible");
  cy.getCy("rnincidentreview-title").should("be.visible");
  cy.getCy("rnincidentreview-content").should("be.visible");
  cy.getCy("rn-dashboard-patient-health").should("be.visible");
  cy.getCy("rn-dashboard-compliance-audit").should("be.visible");
  cy.getCy("rn-dashboard-medication-records").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RnIncidentReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_incident_review");
  
  cy.task("log", "✅ PROGRESS: - Verified RnIncidentReviewScreen successfully!\n");

  });
});
