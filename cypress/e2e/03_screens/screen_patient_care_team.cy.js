// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_care_team", () => {
  it("opens and verifies screen patient_care_team", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/client/roles/client/care-team (Patient Care Team)...");
  cy.visitWithSemantics("/offices/client/roles/client/care-team");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Patient Care Team...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcareteam-screen").should("be.visible");
  cy.getCy("patientcareteam-title").should("be.visible");
  cy.getCy("patientcareteam-content").should("be.visible");
  cy.getCy("patientcare-btn-accessrecords").should("be.visible");
  cy.getCy("patientcare-btn-sendupdate").should("be.visible");
  cy.getCy("patientcare-btn-reportissue").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Patient Care Team...");
  cy.waitAndSee();
  cy.screenshot("patient_care_team");
  
  cy.task("log", "✅ PROGRESS: - Verified Patient Care Team successfully!\n");

  });
});
