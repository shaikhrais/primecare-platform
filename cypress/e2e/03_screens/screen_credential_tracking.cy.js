// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - credential_tracking", () => {
  it("opens and verifies screen credential_tracking", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/compliance_manager/credential-tracking (Credential Tracking)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/credential-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Credential Tracking...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("credentialtracking-screen").should("be.visible");
  cy.getCy("credentialtracking-title").should("be.visible");
  cy.getCy("credentialtracking-content").should("be.visible");
  cy.getCy("credential-status-overview").should("be.visible");
  cy.getCy("credential-update-button").should("be.visible");
  cy.getCy("credential-report-button").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Credential Tracking...");
  cy.waitAndSee();
  cy.screenshot("credential_tracking");
  
  cy.task("log", "✅ PROGRESS: - Verified Credential Tracking successfully!\n");

  });
});
