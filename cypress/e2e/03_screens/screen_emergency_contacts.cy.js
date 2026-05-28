// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - emergency_contacts", () => {
  it("opens and verifies screen emergency_contacts", () => {
    cy.loginAsRole("family");

  cy.visitWithSemantics("/common/emergency-contacts");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("emergencycontacts-screen").should("be.visible");
  cy.getCy("emergencycontacts-title").should("be.visible");
  cy.getCy("emergencycontacts-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("emergency_contacts");

  });
});
