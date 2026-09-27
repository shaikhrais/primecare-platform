// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - portal", () => {
  it("switches active languages for portal", () => {
    cy.loginAsRole("portal");

    cy.switchLanguage("en");
    cy.screenshot("language_portal_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_portal_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_portal_es");

  });
});
