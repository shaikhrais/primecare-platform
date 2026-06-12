// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - gm", () => {
  it("tests all screens for role gm", () => {
    cy.loginAsRole("gm");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /offices/business_development/roles/general_manager/dashboard (GeneralManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/general_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for GeneralManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagerdashboard-screen").should("be.visible");
  cy.getCy("generalmanagerdashboard-title").should("be.visible");
  cy.getCy("generalmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for GeneralManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("general_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified GeneralManagerDashboardScreen successfully!\n");

  });
});
