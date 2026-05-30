// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - appointment", () => {
  it("opens and verifies screen appointment", () => {
    cy.loginAsRole("patient");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/appointment (AppointmentScreen)...");
  cy.visitWithSemantics("/common/appointment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for AppointmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("appointment-screen").should("be.visible");
  cy.getCy("appointment-title").should("be.visible");
  cy.getCy("appointment-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for AppointmentScreen...");
  cy.waitAndSee();
  cy.screenshot("appointment");
  
  cy.task("log", "✅ PROGRESS: - Verified AppointmentScreen successfully!\n");

  });
});
