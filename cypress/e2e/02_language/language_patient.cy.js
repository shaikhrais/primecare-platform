// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - patient", () => {
  it("switches active languages for patient", () => {
    cy.loginAsRole("patient");

    cy.switchLanguage("en");
    cy.screenshot("language_patient_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_patient_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_patient_es");

  });
});
