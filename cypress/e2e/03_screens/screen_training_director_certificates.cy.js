// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_certificates", () => {
  it("opens and verifies screen training_director_certificates", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/training_director/certificates (Training Director Certificates)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/certificates");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Director Certificates...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorcertificates-screen").should("be.visible");
  cy.getCy("trainingdirectorcertificates-title").should("be.visible");
  cy.getCy("trainingdirectorcertificates-content").should("be.visible");
  cy.getCy("certificates-status-card").should("be.visible");
  cy.getCy("error-log-widget").should("be.visible");
  cy.getCy("performance-metrics-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Director Certificates...");
  cy.waitAndSee();
  cy.screenshot("training_director_certificates");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Director Certificates successfully!\n");

  });
});
