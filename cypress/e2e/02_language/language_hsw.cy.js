// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - hsw", () => {
  it("switches active languages for hsw", () => {
    cy.loginAsRole("hsw");

    cy.switchLanguage("en");
    cy.screenshot("language_hsw_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_hsw_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_hsw_es");

  });
});
