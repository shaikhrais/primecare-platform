// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_provider_availability", () => {
  it("opens and verifies screen scheduler_provider_availability", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/scheduler-provider-availability (SchedulerProviderAvailabilityScreen)...");
  cy.visitWithSemantics("/staff/scheduler-provider-availability");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SchedulerProviderAvailabilityScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerprovideravailability-screen").should("be.visible");
  cy.getCy("schedulerprovideravailability-title").should("be.visible");
  cy.getCy("schedulerprovideravailability-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SchedulerProviderAvailabilityScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_provider_availability");
  
  cy.task("log", "✅ PROGRESS: - Verified SchedulerProviderAvailabilityScreen successfully!\n");

  });
});
