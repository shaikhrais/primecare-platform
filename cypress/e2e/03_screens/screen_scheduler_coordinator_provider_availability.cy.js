// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_coordinator_provider_availability", () => {
  it("opens and verifies screen scheduler_coordinator_provider_availability", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/scheduler_coordinator/provider-availability (Scheduler Coordinator Provider Availability)...");
  cy.visitWithSemantics("/offices/franchise/roles/scheduler_coordinator/provider-availability");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Scheduler Coordinator Provider Availability...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercoordinatorprovideravailability-screen").should("be.visible");
  cy.getCy("schedulercoordinatorprovideravailability-title").should("be.visible");
  cy.getCy("schedulercoordinatorprovideravailability-content").should("be.visible");
  cy.getCy("provider-availability-list").should("be.visible");
  cy.getCy("conflict-notification").should("be.visible");
  cy.getCy("schedule-summary").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Scheduler Coordinator Provider Availability...");
  cy.waitAndSee();
  cy.screenshot("scheduler_coordinator_provider_availability");
  
  cy.task("log", "✅ PROGRESS: - Verified Scheduler Coordinator Provider Availability successfully!\n");

  });
});
