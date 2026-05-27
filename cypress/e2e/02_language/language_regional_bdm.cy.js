// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - regional_bdm", () => {
  it("switches active languages for regional_bdm", () => {
    cy.loginAsRole("regional_bdm");

    cy.switchLanguage("en");
    cy.screenshot("language_regional_bdm_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_regional_bdm_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_regional_bdm_es");

  });
});
