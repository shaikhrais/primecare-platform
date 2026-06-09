// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - receptionist_appointments", () => {
  it("opens and verifies screen receptionist_appointments", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Receptionist Appointments)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Receptionist Appointments...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistappointments-screen").should("be.visible");
  cy.getCy("receptionistappointments-title").should("be.visible");
  cy.getCy("receptionistappointments-content").should("be.visible");
  cy.getCy("receptionist-btn-submit-event-log").should("be.visible");
  cy.getCy("receptionist-btn-refresh-audits").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Receptionist Appointments...");
  cy.waitAndSee();
  cy.screenshot("receptionist_appointments");
  
  cy.task("log", "✅ PROGRESS: - Verified Receptionist Appointments successfully!\n");

  });
});
