// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_referrals", () => {
  it("opens and verifies screen intake_coordinator_referrals", () => {
    cy.loginAsRole("volunteer_coordinator");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/intake-coordinator-referrals (IntakeCoordinatorReferralsScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-referrals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for IntakeCoordinatorReferralsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorreferrals-screen").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-title").should("be.visible");
  cy.getCy("intakecoordinatorreferrals-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-add").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-track-hours").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for IntakeCoordinatorReferralsScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_referrals");
  
  cy.task("log", "✅ PROGRESS: - Verified IntakeCoordinatorReferralsScreen successfully!\n");

  });
});
