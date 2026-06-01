// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - school_health_program_dashboard", () => {
  it("opens and verifies screen school_health_program_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (School Health Program Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for School Health Program Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for School Health Program Dashboard...");
  cy.waitAndSee();
  cy.screenshot("school_health_program_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified School Health Program Dashboard successfully!\n");

  });
});
