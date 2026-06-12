// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - psw", () => {
  it("tests all screens for role psw", () => {
    cy.loginAsRole("psw");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /offices/clinical/roles/psw/dashboard (PswDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for PswDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdashboard-screen").should("be.visible");
  cy.getCy("pswdashboard-title").should("be.visible");
  // cy.getCy("pswdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for PswDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified PswDashboardScreen successfully!\n");

  });
});
