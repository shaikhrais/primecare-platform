// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - governance", () => {
  it("switches active languages for governance", () => {
    cy.loginAsRole("governance");

    cy.switchLanguage("en");
    cy.screenshot("language_governance_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_governance_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_governance_es");

  });
});
