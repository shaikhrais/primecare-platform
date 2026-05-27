// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_documents", () => {
  it("opens and verifies screen intake_coordinator_documents", () => {
    cy.loginAsRole("volunteer_coordinator");

  cy.visit("/executive/intake-coordinator-documents");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordocuments-screen").should("be.visible");
  cy.getCy("intakecoordinatordocuments-title").should("be.visible");
  cy.getCy("intakecoordinatordocuments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_documents");

  });
});
