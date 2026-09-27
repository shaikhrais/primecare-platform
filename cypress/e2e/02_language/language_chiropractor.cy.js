// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - chiropractor", () => {
  it("switches active languages for chiropractor", () => {
    cy.loginAsRole("chiropractor");

    cy.switchLanguage("en");
    cy.screenshot("language_chiropractor_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_chiropractor_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_chiropractor_es");

  });
});
