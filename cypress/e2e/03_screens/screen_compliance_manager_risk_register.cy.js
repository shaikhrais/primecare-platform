// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_manager_risk_register", () => {
  it("opens and verifies screen compliance_manager_risk_register", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Compliance Manager Risk Register)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Compliance Manager Risk Register...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Compliance Manager Risk Register...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_risk_register");
  
  cy.task("log", "✅ PROGRESS: - Verified Compliance Manager Risk Register successfully!\n");

  });
});
