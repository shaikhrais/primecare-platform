// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - infection_control_dashboard", () => {
  it("opens and verifies screen infection_control_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Infection Control Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Infection Control Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infectioncontroldashboard-screen").should("be.visible");
  cy.getCy("infectioncontroldashboard-title").should("be.visible");
  cy.getCy("infectioncontroldashboard-content").should("be.visible");
  cy.getCy("infection-dashboard-btn-view-reports").should("be.visible");
  cy.getCy("infection-dashboard-btn-collaborate").should("be.visible");
  cy.getCy("infection-dashboard-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Infection Control Dashboard...");
  cy.waitAndSee();
  cy.screenshot("infection_control_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Infection Control Dashboard successfully!\n");

  });
});
