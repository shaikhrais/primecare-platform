// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - credential_expiry", () => {
  it("opens and verifies screen credential_expiry", () => {
    cy.loginAsRole("hr_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/credential-expiry (CredentialExpiryScreen)...");
  cy.visitWithSemantics("/management/credential-expiry");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CredentialExpiryScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("credentialexpiry-screen").should("be.visible");
  cy.getCy("credentialexpiry-title").should("be.visible");
  cy.getCy("credentialexpiry-content").should("be.visible");
  cy.getCy("hrdashboard-btn-refresh").should("be.visible");
  cy.getCy("hrdashboard-btn-generate-report").should("be.visible");
  cy.getCy("hrdashboard-btn-view-details").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CredentialExpiryScreen...");
  cy.waitAndSee();
  cy.screenshot("credential_expiry");
  
  cy.task("log", "✅ PROGRESS: - Verified CredentialExpiryScreen successfully!\n");

  });
});
