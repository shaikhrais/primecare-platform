// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_owner_compliance", () => {
  it("opens and verifies screen franchise_owner_compliance", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/franchise-owner-compliance (FranchiseOwnerComplianceScreen)...");
  cy.visitWithSemantics("/executive/franchise-owner-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FranchiseOwnerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownercompliance-screen").should("be.visible");
  cy.getCy("franchiseownercompliance-title").should("be.visible");
  cy.getCy("franchiseownercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FranchiseOwnerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified FranchiseOwnerComplianceScreen successfully!\n");

  });
});
