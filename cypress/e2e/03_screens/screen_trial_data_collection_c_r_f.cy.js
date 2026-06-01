// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - trial_data_collection_c_r_f", () => {
  it("opens and verifies screen trial_data_collection_c_r_f", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Trial Data Collection C R F)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Trial Data Collection C R F...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Trial Data Collection C R F...");
  cy.waitAndSee();
  cy.screenshot("trial_data_collection_c_r_f");
  
  cy.task("log", "✅ PROGRESS: - Verified Trial Data Collection C R F successfully!\n");

  });
});
