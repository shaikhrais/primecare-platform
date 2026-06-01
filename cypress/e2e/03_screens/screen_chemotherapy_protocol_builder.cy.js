// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chemotherapy_protocol_builder", () => {
  it("opens and verifies screen chemotherapy_protocol_builder", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Chemotherapy Protocol Builder)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Chemotherapy Protocol Builder...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Chemotherapy Protocol Builder...");
  cy.waitAndSee();
  cy.screenshot("chemotherapy_protocol_builder");
  
  cy.task("log", "✅ PROGRESS: - Verified Chemotherapy Protocol Builder successfully!\n");

  });
});
