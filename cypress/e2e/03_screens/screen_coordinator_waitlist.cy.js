// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coordinator_waitlist", () => {
  it("opens and verifies screen coordinator_waitlist", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/coordinator-waitlist (CoordinatorWaitlistScreen)...");
  cy.visitWithSemantics("/staff/coordinator-waitlist");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CoordinatorWaitlistScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coordinatorwaitlist-screen").should("be.visible");
  cy.getCy("coordinatorwaitlist-title").should("be.visible");
  cy.getCy("coordinatorwaitlist-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CoordinatorWaitlistScreen...");
  cy.waitAndSee();
  cy.screenshot("coordinator_waitlist");
  
  cy.task("log", "✅ PROGRESS: - Verified CoordinatorWaitlistScreen successfully!\n");

  });
});
