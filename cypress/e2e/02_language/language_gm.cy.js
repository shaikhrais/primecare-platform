// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - gm", () => {
  it("switches active languages for gm", () => {
    cy.loginAsRole("gm");

    cy.switchLanguage("en");
    cy.screenshot("language_gm_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_gm_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_gm_es");

  });
});
