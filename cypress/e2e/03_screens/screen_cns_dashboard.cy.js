// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cns_dashboard", () => {
  it("opens and verifies screen cns_dashboard", () => {
    cy.loginAsRole("cns");

  cy.task("log", "⏳ PROGRESS: - Navigating to /clinical/cns-dashboard (CnsDashboardScreen)...");
  cy.visitWithSemantics("/clinical/cns-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CnsDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cnsdashboard-screen").should("be.visible");
  cy.getCy("cnsdashboard-title").should("be.visible");
  cy.getCy("cnsdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CnsDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("cns_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified CnsDashboardScreen successfully!\n");

  });
});
