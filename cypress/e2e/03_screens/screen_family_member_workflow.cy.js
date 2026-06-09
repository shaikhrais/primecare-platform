// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_member_workflow", () => {
  it("opens and verifies screen family_member_workflow", () => {
    cy.loginAsRole("family");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/family-member-workflow (FamilyMemberWorkflowScreen)...");
  cy.visitWithSemantics("/common/family-member-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FamilyMemberWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberworkflow-screen").should("be.visible");
  cy.getCy("familymemberworkflow-title").should("be.visible");
  cy.getCy("familymemberworkflow-content").should("be.visible");
  cy.getCy("family-member-btn-execute-1").should("be.visible");
  cy.getCy("family-member-btn-action-sweep").should("be.visible");
  cy.getCy("family-member-dashboard-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FamilyMemberWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified FamilyMemberWorkflowScreen successfully!\n");

  });
});
