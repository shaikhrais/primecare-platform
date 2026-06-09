// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - unknown_dashboard", () => {
  it("opens and verifies screen unknown_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Unknown Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Unknown Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("unknowndashboard-screen").should("be.visible");
  cy.getCy("unknowndashboard-title").should("be.visible");
  cy.getCy("unknowndashboard-content").should("be.visible");
  cy.getCy("dashboard-btn-log-event").should("be.visible");
  cy.getCy("dashboard-btn-view-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Unknown Dashboard...");
  cy.waitAndSee();
  cy.screenshot("unknown_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Unknown Dashboard successfully!\n");

  });
});
