// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_new_intakes", () => {
  it("opens and verifies screen intake_coordinator_new_intakes", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Intake Coordinator New Intakes)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Intake Coordinator New Intakes...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Intake Coordinator New Intakes...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_new_intakes");
  
  cy.task("log", "✅ PROGRESS: - Verified Intake Coordinator New Intakes successfully!\n");

  });
});
