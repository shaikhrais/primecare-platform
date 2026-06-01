// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - multi_center_trial_collaboration", () => {
  it("opens and verifies screen multi_center_trial_collaboration", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Multi Center Trial Collaboration)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Multi Center Trial Collaboration...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Multi Center Trial Collaboration...");
  cy.waitAndSee();
  cy.screenshot("multi_center_trial_collaboration");
  
  cy.task("log", "✅ PROGRESS: - Verified Multi Center Trial Collaboration successfully!\n");

  });
});
