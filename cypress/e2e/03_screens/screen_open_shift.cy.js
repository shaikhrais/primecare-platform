// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - open_shift", () => {
  it("opens and verifies screen open_shift", () => {
    cy.loginAsRole("scheduler");

  cy.visit("/staff/open-shift");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("openshift-screen").should("be.visible");
  cy.getCy("openshift-title").should("be.visible");
  cy.getCy("openshift-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("open_shift");

  });
});
