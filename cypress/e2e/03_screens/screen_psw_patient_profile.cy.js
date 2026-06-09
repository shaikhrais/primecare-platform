// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_patient_profile", () => {
  it("opens and verifies screen psw_patient_profile", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Psw Patient Profile)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Psw Patient Profile...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswpatientprofile-screen").should("be.visible");
  cy.getCy("pswpatientprofile-title").should("be.visible");
  cy.getCy("pswpatientprofile-content").should("be.visible");
  cy.getCy("pswpatient-btn-refresh").should("be.visible");
  cy.getCy("pswpatient-btn-view-compliance").should("be.visible");
  cy.getCy("pswpatient-btn-access-profile").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Psw Patient Profile...");
  cy.waitAndSee();
  cy.screenshot("psw_patient_profile");
  
  cy.task("log", "✅ PROGRESS: - Verified Psw Patient Profile successfully!\n");

  });
});
