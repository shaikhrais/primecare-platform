// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_manager_compliance", () => {
  it("opens and verifies screen hr_manager_compliance", () => {
    cy.loginAsRole("hr_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/hr-manager-compliance (HrManagerComplianceScreen)...");
  cy.visitWithSemantics("/staff/hr-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagercompliance-screen").should("be.visible");
  cy.getCy("hrmanagercompliance-title").should("be.visible");
  cy.getCy("hrmanagercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified HrManagerComplianceScreen successfully!\n");

  });
});
