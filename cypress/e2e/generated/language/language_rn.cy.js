// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - rn", () => {
  it("switches active languages for rn", () => {
    cy.loginAsRole("rn");

    cy.switchLanguage("en");
    cy.screenshot("language_rn_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_rn_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_rn_es");

  });
});
