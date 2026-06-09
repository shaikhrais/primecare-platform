// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_director_credential_expiry", () => {
  it("opens and verifies screen hr_director_credential_expiry", () => {
    cy.loginAsRole("hr_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/hr-director-credential-expiry (HrDirectorCredentialExpiryScreen)...");
  cy.visitWithSemantics("/executive/hr-director-credential-expiry");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrDirectorCredentialExpiryScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorcredentialexpiry-screen").should("be.visible");
  cy.getCy("hrdirectorcredentialexpiry-title").should("be.visible");
  cy.getCy("hrdirectorcredentialexpiry-content").should("be.visible");
  cy.getCy("hr-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("hr-dashboard-btn-view-details").should("be.visible");
  cy.getCy("hr-dashboard-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrDirectorCredentialExpiryScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_credential_expiry");
  
  cy.task("log", "✅ PROGRESS: - Verified HrDirectorCredentialExpiryScreen successfully!\n");

  });
});
