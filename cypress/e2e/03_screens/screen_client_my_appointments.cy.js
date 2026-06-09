// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - client_my_appointments", () => {
  it("opens and verifies screen client_my_appointments", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Client My Appointments)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Client My Appointments...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientmyappointments-screen").should("be.visible");
  cy.getCy("clientmyappointments-title").should("be.visible");
  cy.getCy("clientmyappointments-content").should("be.visible");
  cy.getCy("appointment-list").should("be.visible");
  cy.getCy("btn-cancel-appointment").should("be.visible");
  cy.getCy("btn-reschedule-appointment").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Client My Appointments...");
  cy.waitAndSee();
  cy.screenshot("client_my_appointments");
  
  cy.task("log", "✅ PROGRESS: - Verified Client My Appointments successfully!\n");

  });
});
