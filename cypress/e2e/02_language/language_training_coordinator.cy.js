// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - training_coordinator", () => {
  it("switches active languages for training_coordinator", () => {
    cy.loginAsRole("training_coordinator");

    cy.switchLanguage("en");
    cy.screenshot("language_training_coordinator_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_training_coordinator_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_training_coordinator_es");

  });
});
