// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - caregiver_client_profile", () => {
  it("opens and verifies screen caregiver_client_profile", () => {
    cy.loginAsRole("caregiver");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/caregiver/client-profile (CaregiverClientProfileScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/client-profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CaregiverClientProfileScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverclientprofile-screen").should("be.visible");
  cy.getCy("caregiverclientprofile-title").should("be.visible");
  cy.getCy("caregiverclientprofile-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CaregiverClientProfileScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_client_profile");
  
  cy.task("log", "✅ PROGRESS: - Verified CaregiverClientProfileScreen successfully!\n");

  });
});
