// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - guest_workflow", () => {
  it("opens and verifies screen guest_workflow", () => {
    cy.loginAsRole("guest");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/guest-workflow (GuestWorkflowScreen)...");
  cy.visitWithSemantics("/common/guest-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for GuestWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestworkflow-screen").should("be.visible");
  cy.getCy("guestworkflow-title").should("be.visible");
  cy.getCy("guestworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for GuestWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("guest_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified GuestWorkflowScreen successfully!\n");

  });
});
