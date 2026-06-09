// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_appointments", () => {
  it("opens and verifies screen chiropractor_appointments", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/chiropractor/appointments (ChiropractorAppointmentsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/appointments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ChiropractorAppointmentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorappointments-screen").should("be.visible");
  cy.getCy("chiropractorappointments-title").should("be.visible");
  cy.getCy("chiropractorappointments-content").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-schedule").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-compliance").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-kpi").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ChiropractorAppointmentsScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_appointments");
  
  cy.task("log", "✅ PROGRESS: - Verified ChiropractorAppointmentsScreen successfully!\n");

  });
});
