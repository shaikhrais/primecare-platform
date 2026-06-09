// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - school_health_program_dashboard", () => {
  it("opens and verifies screen school_health_program_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (School Health Program Dashboard)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for School Health Program Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schoolhealthprogramdashboard-screen").should("be.visible");
  cy.getCy("schoolhealthprogramdashboard-title").should("be.visible");
  cy.getCy("schoolhealthprogramdashboard-content").should("be.visible");
  cy.getCy("dashboard-kpi-widget").should("be.visible");
  cy.getCy("dashboard-health-chart").should("be.visible");
  cy.getCy("dashboard-alert-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for School Health Program Dashboard...");
  cy.waitAndSee();
  cy.screenshot("school_health_program_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified School Health Program Dashboard successfully!\n");

  });
});
