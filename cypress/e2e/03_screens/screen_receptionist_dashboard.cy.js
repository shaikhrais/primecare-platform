// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - receptionist_dashboard", () => {
  it("opens and verifies screen receptionist_dashboard", () => {
    cy.loginAsRole("admin");

  cy.visitWithSemantics("/staff/receptionist-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistdashboard-screen").should("be.visible");
  cy.getCy("receptionistdashboard-title").should("be.visible");
  cy.getCy("receptionistdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("receptionist_dashboard");

  });
});
