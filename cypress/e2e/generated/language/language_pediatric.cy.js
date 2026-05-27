// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - pediatric", () => {
  it("switches active languages for pediatric", () => {
    cy.loginAsRole("pediatric");

    cy.switchLanguage("en");
    cy.screenshot("language_pediatric_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_pediatric_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_pediatric_es");

  });
});
