// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ciso_compliance", () => {
  it("opens and verifies screen ciso_compliance", () => {
    cy.loginAsRole("ciso");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/ciso-compliance (CisoComplianceScreen)...");
  cy.visitWithSemantics("/executive/ciso-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CisoComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisocompliance-screen").should("be.visible");
  cy.getCy("cisocompliance-title").should("be.visible");
  cy.getCy("cisocompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CisoComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("ciso_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified CisoComplianceScreen successfully!\n");

  });
});
