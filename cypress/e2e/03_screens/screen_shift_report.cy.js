// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - shift_report", () => {
  it("opens and verifies screen shift_report", () => {
    cy.loginAsRole("rn");

  cy.visitWithSemantics("/rn/shift-report");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shiftreport-screen").should("be.visible");
  cy.getCy("shiftreport-title").should("be.visible");
  cy.getCy("shiftreport-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shift_report");

  });
});
