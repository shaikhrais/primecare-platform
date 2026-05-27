// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - scrum_master", () => {
  it("switches active languages for scrum_master", () => {
    cy.loginAsRole("scrum_master");

    cy.switchLanguage("en");
    cy.screenshot("language_scrum_master_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_scrum_master_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_scrum_master_es");

  });
});
