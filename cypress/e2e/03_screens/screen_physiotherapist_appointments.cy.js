// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_appointments", () => {
  it("opens and verifies screen physiotherapist_appointments", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/physiotherapist/appointments (PhysiotherapistAppointmentsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/appointments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PhysiotherapistAppointmentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistappointments-screen").should("be.visible");
  cy.getCy("physiotherapistappointments-title").should("be.visible");
  cy.getCy("physiotherapistappointments-content").should("be.visible");
  cy.getCy("physio-dashboard-btn-view-appointment").should("be.visible");
  cy.getCy("physio-dashboard-btn-audit-compliance").should("be.visible");
  cy.getCy("physio-dashboard-btn-view-kpis").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PhysiotherapistAppointmentsScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_appointments");
  
  cy.task("log", "✅ PROGRESS: - Verified PhysiotherapistAppointmentsScreen successfully!\n");

  });
});
