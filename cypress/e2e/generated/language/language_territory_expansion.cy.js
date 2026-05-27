// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - territory_expansion", () => {
  it("switches active languages for territory_expansion", () => {
    cy.loginAsRole("territory_expansion");

    cy.switchLanguage("en");
    cy.screenshot("language_territory_expansion_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_territory_expansion_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_territory_expansion_es");

  });
});
