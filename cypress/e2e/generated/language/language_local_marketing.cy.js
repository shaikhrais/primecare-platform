// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - local_marketing", () => {
  it("switches active languages for local_marketing", () => {
    cy.loginAsRole("local_marketing");

    cy.switchLanguage("en");
    cy.screenshot("language_local_marketing_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_local_marketing_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_local_marketing_es");

  });
});
