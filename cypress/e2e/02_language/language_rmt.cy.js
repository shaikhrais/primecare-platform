// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - rmt", () => {
  it("switches active languages for rmt", () => {
    cy.loginAsRole("rmt");

    cy.switchLanguage("en");
    cy.screenshot("language_rmt_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_rmt_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_rmt_es");

  });
});
