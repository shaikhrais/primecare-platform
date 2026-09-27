// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - lpn", () => {
  it("switches active languages for lpn", () => {
    cy.loginAsRole("lpn");

    cy.switchLanguage("en");
    cy.screenshot("language_lpn_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_lpn_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_lpn_es");

  });
});
