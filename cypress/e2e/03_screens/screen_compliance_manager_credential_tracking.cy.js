// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_manager_credential_tracking", () => {
  it("opens and verifies screen compliance_manager_credential_tracking", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Compliance Manager Credential Tracking)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Compliance Manager Credential Tracking...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Compliance Manager Credential Tracking...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_credential_tracking");
  
  cy.task("log", "✅ PROGRESS: - Verified Compliance Manager Credential Tracking successfully!\n");

  });
});
