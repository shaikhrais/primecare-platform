// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - virtual_waiting_room", () => {
  it("opens and verifies screen virtual_waiting_room", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Virtual Waiting Room)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Virtual Waiting Room...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Virtual Waiting Room...");
  cy.waitAndSee();
  cy.screenshot("virtual_waiting_room");
  
  cy.task("log", "✅ PROGRESS: - Verified Virtual Waiting Room successfully!\n");

  });
});
