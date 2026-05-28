// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - caregiver_client_profile", () => {
  it("opens and verifies screen caregiver_client_profile", () => {
    cy.loginAsRole("caregiver");

  cy.visitWithSemantics("/psw/caregiver-client-profile");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverclientprofile-screen").should("be.visible");
  cy.getCy("caregiverclientprofile-title").should("be.visible");
  cy.getCy("caregiverclientprofile-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_client_profile");

  });
});
