// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - marketing", () => {
  it("switches active languages for marketing", () => {
    cy.loginAsRole("marketing");

    cy.switchLanguage("en");
    cy.screenshot("language_marketing_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_marketing_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_marketing_es");

  });
});
