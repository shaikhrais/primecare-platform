// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - rpn", () => {
  it("switches active languages for rpn", () => {
    cy.loginAsRole("rpn");

    cy.switchLanguage("en");
    cy.screenshot("language_rpn_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_rpn_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_rpn_es");

  });
});
