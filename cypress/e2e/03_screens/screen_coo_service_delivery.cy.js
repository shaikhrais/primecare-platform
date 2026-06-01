// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_service_delivery", () => {
  it("opens and verifies screen coo_service_delivery", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Coo Service Delivery)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Coo Service Delivery...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Coo Service Delivery...");
  cy.waitAndSee();
  cy.screenshot("coo_service_delivery");
  
  cy.task("log", "✅ PROGRESS: - Verified Coo Service Delivery successfully!\n");

  });
});
