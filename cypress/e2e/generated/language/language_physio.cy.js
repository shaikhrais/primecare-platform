// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - physio", () => {
  it("switches active languages for physio", () => {
    cy.loginAsRole("physio");

    cy.switchLanguage("en");
    cy.screenshot("language_physio_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_physio_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_physio_es");

  });
});
