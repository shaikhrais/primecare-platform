// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - shareholder", () => {
  it("switches active languages for shareholder", () => {
    cy.loginAsRole("shareholder");

    cy.switchLanguage("en");
    cy.screenshot("language_shareholder_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_shareholder_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_shareholder_es");

  });
});
