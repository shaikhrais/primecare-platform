// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - cns", () => {
  it("tests all screens for role cns", () => {
    cy.loginAsRole("cns");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /clinical/cns-dashboard (CnsDashboardScreen)...");
  cy.visitWithSemantics("/clinical/cns-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for CnsDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cnsdashboard-screen").should("be.visible");
  cy.getCy("cnsdashboard-title").should("be.visible");
  cy.getCy("cnsdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for CnsDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("cns_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified CnsDashboardScreen successfully!\n");

  });
});
