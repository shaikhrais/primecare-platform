// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_outreach_workflow", () => {
  it("opens and verifies screen community_outreach_workflow", () => {
    cy.loginAsRole("community_outreach");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/community-outreach-workflow (CommunityOutreachWorkflowScreen)...");
  cy.visitWithSemantics("/management/community-outreach-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CommunityOutreachWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachworkflow-screen").should("be.visible");
  cy.getCy("communityoutreachworkflow-title").should("be.visible");
  cy.getCy("communityoutreachworkflow-content").should("be.visible");
  cy.getCy("community-outreach-btn-add-event").should("be.visible");
  cy.getCy("community-outreach-btn-submit-feedback").should("be.visible");
  cy.getCy("community-outreach-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CommunityOutreachWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified CommunityOutreachWorkflowScreen successfully!\n");

  });
});
