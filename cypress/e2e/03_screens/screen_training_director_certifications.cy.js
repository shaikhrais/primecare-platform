// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_certifications", () => {
  it("opens and verifies screen training_director_certifications", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/training_director/certifications (Training Director Certifications)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/certifications");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Director Certifications...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorcertifications-screen").should("be.visible");
  cy.getCy("trainingdirectorcertifications-title").should("be.visible");
  cy.getCy("trainingdirectorcertifications-content").should("be.visible");
  cy.getCy("loading-indicator").should("be.visible");
  cy.getCy("error-message").should("be.visible");
  cy.getCy("metrics-summary").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Director Certifications...");
  cy.waitAndSee();
  cy.screenshot("training_director_certifications");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Director Certifications successfully!\n");

  });
});
