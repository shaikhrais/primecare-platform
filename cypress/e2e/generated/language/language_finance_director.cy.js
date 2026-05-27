// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - finance_director", () => {
  it("switches active languages for finance_director", () => {
    cy.loginAsRole("finance_director");

    cy.switchLanguage("en");
    cy.screenshot("language_finance_director_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_finance_director_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_finance_director_es");

  });
});
