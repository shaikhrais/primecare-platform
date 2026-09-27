// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - family", () => {
  it("switches active languages for family", () => {
    cy.loginAsRole("family");

    cy.switchLanguage("en");
    cy.screenshot("language_family_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_family_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_family_es");

  });
});
