// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_coordinator_certifications", () => {
  it("opens and verifies screen training_coordinator_certifications", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Training Coordinator Certifications)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Coordinator Certifications...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatorcertifications-screen").should("be.visible");
  cy.getCy("trainingcoordinatorcertifications-title").should("be.visible");
  cy.getCy("trainingcoordinatorcertifications-content").should("be.visible");
  cy.getCy("certification-status-overview").should("be.visible");
  cy.getCy("certification-update-btn").should("be.visible");
  cy.getCy("generate-report-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Coordinator Certifications...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_certifications");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Coordinator Certifications successfully!\n");

  });
});
