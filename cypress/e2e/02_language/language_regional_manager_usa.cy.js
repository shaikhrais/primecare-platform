// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - regional_manager_usa", () => {
  it("switches active languages for regional_manager_usa", () => {
    cy.loginAsRole("regional_manager_usa");

    cy.switchLanguage("en");
    cy.screenshot("language_regional_manager_usa_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_regional_manager_usa_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_regional_manager_usa_es");

  });
});
