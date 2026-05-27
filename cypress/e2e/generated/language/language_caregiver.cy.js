// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - caregiver", () => {
  it("switches active languages for caregiver", () => {
    cy.loginAsRole("caregiver");

    cy.switchLanguage("en");
    cy.screenshot("language_caregiver_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_caregiver_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_caregiver_es");

  });
});
