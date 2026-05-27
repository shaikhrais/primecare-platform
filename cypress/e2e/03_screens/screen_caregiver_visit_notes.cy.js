// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - caregiver_visit_notes", () => {
  it("opens and verifies screen caregiver_visit_notes", () => {
    cy.loginAsRole("caregiver");

  cy.visit("/psw/caregiver-visit-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregivervisitnotes-screen").should("be.visible");
  cy.getCy("caregivervisitnotes-title").should("be.visible");
  cy.getCy("caregivervisitnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_visit_notes");

  });
});
