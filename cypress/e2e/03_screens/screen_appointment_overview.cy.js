// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - appointment_overview", () => {
  it("opens and verifies screen appointment_overview", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/appointment-overview (AppointmentOverviewScreen)...");
  cy.visitWithSemantics("/executive/appointment-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for AppointmentOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("appointmentoverview-screen").should("be.visible");
  cy.getCy("appointmentoverview-title").should("be.visible");
  cy.getCy("appointmentoverview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for AppointmentOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("appointment_overview");
  
  cy.task("log", "✅ PROGRESS: - Verified AppointmentOverviewScreen successfully!\n");

  });
});
