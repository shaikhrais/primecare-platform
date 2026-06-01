// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_manager_corrective_actions", () => {
  it("opens and verifies screen compliance_manager_corrective_actions", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Compliance Manager Corrective Actions)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Compliance Manager Corrective Actions...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Compliance Manager Corrective Actions...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_corrective_actions");
  
  cy.task("log", "✅ PROGRESS: - Verified Compliance Manager Corrective Actions successfully!\n");

  });
});
