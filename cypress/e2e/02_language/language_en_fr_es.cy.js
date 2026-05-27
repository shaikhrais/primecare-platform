// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.

describe("Language - EN FR ES", () => {
  it("switches active languages for governance role", () => {
    cy.loginAsRole("governance");

    cy.switchLanguage("en");
    cy.screenshot("language_governance_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_governance_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_governance_es");
  });
});
