// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_compliance", () => {
  it("opens and verifies screen psw_compliance", () => {
    cy.loginAsRole("psw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/psw/psw-compliance (PswComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/psw-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PswComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcompliance-screen").should("be.visible");
  cy.getCy("pswcompliance-title").should("be.visible");
  cy.getCy("pswcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PswComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified PswComplianceScreen successfully!\n");

  });
});
