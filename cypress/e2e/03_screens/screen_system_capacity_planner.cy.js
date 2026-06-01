// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - system_capacity_planner", () => {
  it("opens and verifies screen system_capacity_planner", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (System Capacity Planner)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for System Capacity Planner...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for System Capacity Planner...");
  cy.waitAndSee();
  cy.screenshot("system_capacity_planner");
  
  cy.task("log", "✅ PROGRESS: - Verified System Capacity Planner successfully!\n");

  });
});
