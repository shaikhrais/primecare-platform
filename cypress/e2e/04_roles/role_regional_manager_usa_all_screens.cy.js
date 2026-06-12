// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - regional_manager_usa", () => {
  it("tests all screens for role regional_manager_usa", () => {
    cy.loginAsRole("regional_manager_usa");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /offices/business_development/roles/regional_manager_usa/dashboard (RegionalManagerUsaDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_manager_usa/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for RegionalManagerUsaDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusadashboard-screen").should("be.visible");
  cy.getCy("regionalmanagerusadashboard-title").should("be.visible");
  cy.getCy("regionalmanagerusadashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for RegionalManagerUsaDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified RegionalManagerUsaDashboardScreen successfully!\n");

  });
});
