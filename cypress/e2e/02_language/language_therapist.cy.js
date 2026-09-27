// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - therapist", () => {
  it("switches active languages for therapist", () => {
    cy.loginAsRole("therapist");

    cy.switchLanguage("en");
    cy.screenshot("language_therapist_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_therapist_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_therapist_es");

  });
});
