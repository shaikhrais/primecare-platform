// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - clinical_director_incident_review", () => {
  it("opens and verifies screen clinical_director_incident_review", () => {
    cy.loginAsRole("clinical_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/clinical_director/incident-review (ClinicalDirectorIncidentReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/incident-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ClinicalDirectorIncidentReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectorincidentreview-screen").should("be.visible");
  cy.getCy("clinicaldirectorincidentreview-title").should("be.visible");
  cy.getCy("clinicaldirectorincidentreview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ClinicalDirectorIncidentReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_incident_review");
  
  cy.task("log", "✅ PROGRESS: - Verified ClinicalDirectorIncidentReviewScreen successfully!\n");

  });
});
