// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_emergency_contacts", () => {
  it("opens and verifies screen family_emergency_contacts", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Family Emergency Contacts)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Family Emergency Contacts...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Family Emergency Contacts...");
  cy.waitAndSee();
  cy.screenshot("family_emergency_contacts");
  
  cy.task("log", "✅ PROGRESS: - Verified Family Emergency Contacts successfully!\n");

  });
});
