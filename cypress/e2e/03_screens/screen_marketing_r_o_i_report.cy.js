// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - marketing_r_o_i_report", () => {
  it("opens and verifies screen marketing_r_o_i_report", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Marketing R O I Report)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Marketing R O I Report...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Marketing R O I Report...");
  cy.waitAndSee();
  cy.screenshot("marketing_r_o_i_report");
  
  cy.task("log", "✅ PROGRESS: - Verified Marketing R O I Report successfully!\n");

  });
});
