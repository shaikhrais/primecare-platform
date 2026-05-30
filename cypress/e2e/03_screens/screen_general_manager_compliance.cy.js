// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - general_manager_compliance", () => {
  it("opens and verifies screen general_manager_compliance", () => {
    cy.loginAsRole("gm");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/general-manager-compliance (GeneralManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/general-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for GeneralManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagercompliance-screen").should("be.visible");
  cy.getCy("generalmanagercompliance-title").should("be.visible");
  cy.getCy("generalmanagercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for GeneralManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("general_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified GeneralManagerComplianceScreen successfully!\n");

  });
});
