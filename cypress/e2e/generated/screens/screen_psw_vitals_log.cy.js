// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_vitals_log", () => {
  it("opens and verifies screen psw_vitals_log", () => {
    cy.loginAsRole("psw");

  cy.visit("/psw/psw-vitals-log");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswvitalslog-screen").should("be.visible");
  cy.getCy("pswvitalslog-title").should("be.visible");
  cy.getCy("pswvitalslog-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_vitals_log");

  });
});
