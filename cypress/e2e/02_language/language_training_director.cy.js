// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - training_director", () => {
  it("switches active languages for training_director", () => {
    cy.loginAsRole("training_director");

    cy.switchLanguage("en");
    cy.screenshot("language_training_director_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_training_director_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_training_director_es");

  });
});
