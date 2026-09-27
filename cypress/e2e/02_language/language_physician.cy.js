// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - physician", () => {
  it("switches active languages for physician", () => {
    cy.loginAsRole("physician");

    cy.switchLanguage("en");
    cy.screenshot("language_physician_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_physician_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_physician_es");

  });
});
