// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - receptionist_analytics", () => {
  it("opens and verifies screen receptionist_analytics", () => {
    cy.loginAsRole("admin");

  cy.visitWithSemantics("/staff/receptionist-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistanalytics-screen").should("be.visible");
  cy.getCy("receptionistanalytics-title").should("be.visible");
  cy.getCy("receptionistanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("receptionist_analytics");

  });
});
