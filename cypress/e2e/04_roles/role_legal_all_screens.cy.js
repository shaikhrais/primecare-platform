// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - legal", () => {
  it("tests all screens for role legal", () => {
    cy.loginAsRole("legal");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /offices/corporate/roles/legal/dashboard (LegalDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/legal/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for LegalDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legaldashboard-screen").should("be.visible");
  cy.getCy("legaldashboard-title").should("be.visible");
  cy.getCy("legaldashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for LegalDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("legal_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified LegalDashboardScreen successfully!\n");

  });
});
