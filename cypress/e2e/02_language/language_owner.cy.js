// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - owner", () => {
  it("switches active languages for owner", () => {
    cy.loginAsRole("owner");

    cy.switchLanguage("en");
    cy.screenshot("language_owner_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_owner_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_owner_es");

  });
});
