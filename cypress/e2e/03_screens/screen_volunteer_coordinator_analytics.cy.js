// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - volunteer_coordinator_analytics", () => {
  it("opens and verifies screen volunteer_coordinator_analytics", () => {
    cy.loginAsRole("volunteer");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/volunteer-coordinator-analytics (VolunteerCoordinatorAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/volunteer-coordinator-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for VolunteerCoordinatorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatoranalytics-screen").should("be.visible");
  cy.getCy("volunteercoordinatoranalytics-title").should("be.visible");
  cy.getCy("volunteercoordinatoranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for VolunteerCoordinatorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified VolunteerCoordinatorAnalyticsScreen successfully!\n");

  });
});
