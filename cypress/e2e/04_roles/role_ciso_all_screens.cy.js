// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - ciso", () => {
  it("tests all screens for role ciso", () => {
    cy.loginAsRole("ciso");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /offices/corporate/roles/ciso/dashboard (CisoDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/ciso/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for CisoDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisodashboard-screen").should("be.visible");
  cy.getCy("cisodashboard-title").should("be.visible");
  cy.getCy("cisodashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for CisoDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("ciso_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified CisoDashboardScreen successfully!\n");

  });
});
