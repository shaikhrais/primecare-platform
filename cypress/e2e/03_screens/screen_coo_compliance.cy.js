// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_compliance", () => {
  it("opens and verifies screen coo_compliance", () => {
    cy.loginAsRole("coo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/coo-compliance (CooComplianceScreen)...");
  cy.visitWithSemantics("/executive/coo-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CooComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coocompliance-screen").should("be.visible");
  cy.getCy("coocompliance-title").should("be.visible");
  cy.getCy("coocompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CooComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified CooComplianceScreen successfully!\n");

  });
});
