// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - cto", () => {
  it("switches active languages for cto", () => {
    cy.loginAsRole("cto");

    cy.switchLanguage("en");
    cy.screenshot("language_cto_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_cto_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_cto_es");

  });
});
