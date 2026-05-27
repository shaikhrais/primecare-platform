// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - system_verification", () => {
  it("switches active languages for system_verification", () => {
    cy.loginAsRole("system_verification");

    cy.switchLanguage("en");
    cy.screenshot("language_system_verification_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_system_verification_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_system_verification_es");

  });
});
