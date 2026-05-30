// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - owner_compliance", () => {
  it("opens and verifies screen owner_compliance", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/owner-compliance (OwnerComplianceScreen)...");
  cy.visitWithSemantics("/executive/owner-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OwnerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownercompliance-screen").should("be.visible");
  cy.getCy("ownercompliance-title").should("be.visible");
  cy.getCy("ownercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OwnerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified OwnerComplianceScreen successfully!\n");

  });
});
