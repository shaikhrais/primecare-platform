// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cx_director_compliance", () => {
  it("opens and verifies screen cx_director_compliance", () => {
    cy.loginAsRole("cx_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/cx-director-compliance (CxDirectorComplianceScreen)...");
  cy.visitWithSemantics("/executive/cx-director-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CxDirectorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectorcompliance-screen").should("be.visible");
  cy.getCy("cxdirectorcompliance-title").should("be.visible");
  cy.getCy("cxdirectorcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CxDirectorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("cx_director_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified CxDirectorComplianceScreen successfully!\n");

  });
});
