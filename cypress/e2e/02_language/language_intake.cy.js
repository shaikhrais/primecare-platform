// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - intake", () => {
  it("switches active languages for intake", () => {
    cy.loginAsRole("intake");

    cy.switchLanguage("en");
    cy.screenshot("language_intake_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_intake_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_intake_es");

  });
});
