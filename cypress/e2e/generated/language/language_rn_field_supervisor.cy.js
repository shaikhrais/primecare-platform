// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - rn_field_supervisor", () => {
  it("switches active languages for rn_field_supervisor", () => {
    cy.loginAsRole("rn_field_supervisor");

    cy.switchLanguage("en");
    cy.screenshot("language_rn_field_supervisor_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_rn_field_supervisor_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_rn_field_supervisor_es");

  });
});
