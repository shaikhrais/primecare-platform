// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - employee_analytics", () => {
  it("opens and verifies screen employee_analytics", () => {
    cy.loginAsRole("employee");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/employee-analytics (Employee Analytics)...");
  cy.visitWithSemantics("/staff/employee-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Employee Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employee analytics-screen").should("be.visible");
  cy.getCy("employee analytics-title").should("be.visible");
  cy.getCy("employee analytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Employee Analytics...");
  cy.waitAndSee();
  cy.screenshot("employee_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified Employee Analytics successfully!\n");

  });
});
