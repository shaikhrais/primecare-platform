// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_case_study_repository", () => {
  it("opens and verifies screen patient_case_study_repository", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Patient Case Study Repository)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Patient Case Study Repository...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcasestudyrepository-screen").should("be.visible");
  cy.getCy("patientcasestudyrepository-title").should("be.visible");
  cy.getCy("patientcasestudyrepository-content").should("be.visible");
  cy.getCy("case-study-list").should("be.visible");
  cy.getCy("loading-indicator").should("be.visible");
  cy.getCy("error-message").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Patient Case Study Repository...");
  cy.waitAndSee();
  cy.screenshot("patient_case_study_repository");
  
  cy.task("log", "✅ PROGRESS: - Verified Patient Case Study Repository successfully!\n");

  });
});
