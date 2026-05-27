// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - compliance", () => {
  it("switches active languages for compliance", () => {
    cy.loginAsRole("compliance");

    cy.switchLanguage("en");
    cy.screenshot("language_compliance_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_compliance_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_compliance_es");

  });
});
