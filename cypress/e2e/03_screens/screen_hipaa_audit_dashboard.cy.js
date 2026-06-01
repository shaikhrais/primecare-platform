// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hipaa_audit_dashboard", () => {
  it("opens and verifies screen hipaa_audit_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Hipaa Audit Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Hipaa Audit Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Hipaa Audit Dashboard...");
  cy.waitAndSee();
  cy.screenshot("hipaa_audit_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Hipaa Audit Dashboard successfully!\n");

  });
});
