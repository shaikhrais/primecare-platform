// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - ceo", () => {
  it("switches active languages for ceo", () => {
    cy.loginAsRole("ceo");

    cy.switchLanguage("en");
    cy.screenshot("language_ceo_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_ceo_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_ceo_es");

  });
});
