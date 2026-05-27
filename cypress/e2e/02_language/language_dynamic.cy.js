// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - dynamic", () => {
  it("switches active languages for dynamic", () => {
    cy.loginAsRole("dynamic");

    cy.switchLanguage("en");
    cy.screenshot("language_dynamic_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_dynamic_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_dynamic_es");

  });
});
