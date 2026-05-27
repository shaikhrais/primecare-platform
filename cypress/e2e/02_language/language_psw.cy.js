// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - psw", () => {
  it("switches active languages for psw", () => {
    cy.loginAsRole("psw");

    cy.switchLanguage("en");
    cy.screenshot("language_psw_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_psw_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_psw_es");

  });
});
