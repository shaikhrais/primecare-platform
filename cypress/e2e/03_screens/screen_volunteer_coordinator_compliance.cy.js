// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - volunteer_coordinator_compliance", () => {
  it("opens and verifies screen volunteer_coordinator_compliance", () => {
    cy.loginAsRole("volunteer");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/volunteer-coordinator-compliance (VolunteerCoordinatorComplianceScreen)...");
  cy.visitWithSemantics("/staff/volunteer-coordinator-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for VolunteerCoordinatorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatorcompliance-screen").should("be.visible");
  cy.getCy("volunteercoordinatorcompliance-title").should("be.visible");
  cy.getCy("volunteercoordinatorcompliance-content").should("be.visible");
  cy.getCy("compliance-status-card").should("be.visible");
  cy.getCy("audit-log-viewer").should("be.visible");
  cy.getCy("training-notification-banner").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for VolunteerCoordinatorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified VolunteerCoordinatorComplianceScreen successfully!\n");

  });
});
