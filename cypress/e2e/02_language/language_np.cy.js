// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - np", () => {
  it("switches active languages for np", () => {
    cy.loginAsRole("np");

    cy.switchLanguage("en");
    cy.screenshot("language_np_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_np_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_np_es");

  });
});
