// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - cfo", () => {
  it("switches active languages for cfo", () => {
    cy.loginAsRole("cfo");

    cy.switchLanguage("en");
    cy.screenshot("language_cfo_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_cfo_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_cfo_es");

  });
});
