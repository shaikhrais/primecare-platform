// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - cns", () => {
  it("switches active languages for cns", () => {
    cy.loginAsRole("cns");

    cy.switchLanguage("en");
    cy.screenshot("language_cns_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_cns_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_cns_es");

  });
});
