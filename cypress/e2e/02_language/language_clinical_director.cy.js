// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - clinical_director", () => {
  it("switches active languages for clinical_director", () => {
    cy.loginAsRole("clinical_director");

    cy.switchLanguage("en");
    cy.screenshot("language_clinical_director_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_clinical_director_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_clinical_director_es");

  });
});
