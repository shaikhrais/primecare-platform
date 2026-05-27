// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - ciso", () => {
  it("switches active languages for ciso", () => {
    cy.loginAsRole("ciso");

    cy.switchLanguage("en");
    cy.screenshot("language_ciso_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_ciso_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_ciso_es");

  });
});
