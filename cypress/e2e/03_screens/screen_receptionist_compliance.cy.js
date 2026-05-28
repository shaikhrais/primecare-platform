// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - receptionist_compliance", () => {
  it("opens and verifies screen receptionist_compliance", () => {
    cy.loginAsRole("admin");

  cy.visitWithSemantics("/staff/receptionist-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistcompliance-screen").should("be.visible");
  cy.getCy("receptionistcompliance-title").should("be.visible");
  cy.getCy("receptionistcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("receptionist_compliance");

  });
});
