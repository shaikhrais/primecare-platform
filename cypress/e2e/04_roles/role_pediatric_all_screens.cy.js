// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - pediatric", () => {
  it("tests all screens for role pediatric", () => {
    cy.loginAsRole("pediatric");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /clinical/pediatric-dashboard (PediatricDashboardScreen)...");
  cy.visitWithSemantics("/clinical/pediatric-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for PediatricDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pediatricdashboard-screen").should("be.visible");
  cy.getCy("pediatricdashboard-title").should("be.visible");
  cy.getCy("pediatricdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for PediatricDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("pediatric_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified PediatricDashboardScreen successfully!\n");

  });
});
