// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_manager_staff_coordination", () => {
  it("opens and verifies screen operations_manager_staff_coordination", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/operations_manager/staff-coordination (Operations Manager Staff Coordination)...");
  cy.visitWithSemantics("/offices/franchise/roles/operations_manager/staff-coordination");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Operations Manager Staff Coordination...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerstaffcoordination-screen").should("be.visible");
  cy.getCy("operationsmanagerstaffcoordination-title").should("be.visible");
  cy.getCy("operationsmanagerstaffcoordination-content").should("be.visible");
  cy.getCy("staff-performance-metric-card").should("be.visible");
  cy.getCy("staff-schedule-chart").should("be.visible");
  cy.getCy("operational-issue-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Operations Manager Staff Coordination...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_staff_coordination");
  
  cy.task("log", "✅ PROGRESS: - Verified Operations Manager Staff Coordination successfully!\n");

  });
});
