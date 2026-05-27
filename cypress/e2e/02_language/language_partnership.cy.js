// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - partnership", () => {
  it("switches active languages for partnership", () => {
    cy.loginAsRole("partnership");

    cy.switchLanguage("en");
    cy.screenshot("language_partnership_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_partnership_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_partnership_es");

  });
});
