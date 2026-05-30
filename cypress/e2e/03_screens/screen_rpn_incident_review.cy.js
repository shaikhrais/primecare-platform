// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_incident_review", () => {
  it("opens and verifies screen rpn_incident_review", () => {
    cy.loginAsRole("rpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rpn/rpn-incident-review (RpnIncidentReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-incident-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RpnIncidentReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnincidentreview-screen").should("be.visible");
  cy.getCy("rpnincidentreview-title").should("be.visible");
  cy.getCy("rpnincidentreview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RpnIncidentReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_incident_review");
  
  cy.task("log", "✅ PROGRESS: - Verified RpnIncidentReviewScreen successfully!\n");

  });
});
