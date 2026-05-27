// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_documents", () => {
  it("opens and verifies screen psw_documents", () => {
    cy.loginAsRole("psw");

  cy.visit("/psw/psw-documents");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdocuments-screen").should("be.visible");
  cy.getCy("pswdocuments-title").should("be.visible");
  cy.getCy("pswdocuments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_documents");

  });
});
