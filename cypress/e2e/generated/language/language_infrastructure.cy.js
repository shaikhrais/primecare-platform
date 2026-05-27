// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - infrastructure", () => {
  it("switches active languages for infrastructure", () => {
    cy.loginAsRole("infrastructure");

    cy.switchLanguage("en");
    cy.screenshot("language_infrastructure_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_infrastructure_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_infrastructure_es");

  });
});
