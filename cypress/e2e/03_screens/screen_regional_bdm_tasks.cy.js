// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_tasks", () => {
  it("opens and verifies screen regional_bdm_tasks", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/regional_bdm/tasks (Regional Bdm Tasks)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_bdm/tasks");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regional Bdm Tasks...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmtasks-screen").should("be.visible");
  cy.getCy("regionalbdmtasks-title").should("be.visible");
  cy.getCy("regionalbdmtasks-content").should("be.visible");
  cy.getCy("regionalbdm-btn-assign-task").should("be.visible");
  cy.getCy("regionalbdm-btn-set-target").should("be.visible");
  cy.getCy("regionalbdm-btn-review-reports").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regional Bdm Tasks...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_tasks");
  
  cy.task("log", "✅ PROGRESS: - Verified Regional Bdm Tasks successfully!\n");

  });
});
