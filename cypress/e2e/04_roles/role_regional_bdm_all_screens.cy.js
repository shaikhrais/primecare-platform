// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - regional_bdm", () => {
  it("tests all screens for role regional_bdm", () => {
    cy.loginAsRole("regional_bdm");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /offices/business_development/roles/regional_bdm/dashboard (RegionalBdmDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_bdm/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for RegionalBdmDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmdashboard-screen").should("be.visible");
  cy.getCy("regionalbdmdashboard-title").should("be.visible");
  cy.getCy("regionalbdmdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for RegionalBdmDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified RegionalBdmDashboardScreen successfully!\n");

  });
});
