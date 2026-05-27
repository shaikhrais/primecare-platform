// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - volunteer", () => {
  it("switches active languages for volunteer", () => {
    cy.loginAsRole("volunteer");

    cy.switchLanguage("en");
    cy.screenshot("language_volunteer_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_volunteer_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_volunteer_es");

  });
});
