// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - ops_manager", () => {
  it("switches active languages for ops_manager", () => {
    cy.loginAsRole("ops_manager");

    cy.switchLanguage("en");
    cy.screenshot("language_ops_manager_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_ops_manager_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_ops_manager_es");

  });
});
