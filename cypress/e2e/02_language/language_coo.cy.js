// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - coo", () => {
  it("switches active languages for coo", () => {
    cy.loginAsRole("coo");

    cy.switchLanguage("en");
    cy.screenshot("language_coo_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_coo_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_coo_es");

  });
});
