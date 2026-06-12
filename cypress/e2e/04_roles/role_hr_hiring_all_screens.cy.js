// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - hr_hiring", () => {
  it("tests all screens for role hr_hiring", () => {
    cy.loginAsRole("hr_hiring");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /offices/corporate/roles/hr_hiring/dashboard (HrHiringDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/hr_hiring/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for HrHiringDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringdashboard-screen").should("be.visible");
  cy.getCy("hrhiringdashboard-title").should("be.visible");
  cy.getCy("hrhiringdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for HrHiringDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified HrHiringDashboardScreen successfully!\n");

  });
});
