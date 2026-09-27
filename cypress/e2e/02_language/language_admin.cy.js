// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - admin", () => {
  it("switches active languages for admin", () => {
    cy.loginAsRole("admin");

    cy.switchLanguage("en");
    cy.screenshot("language_admin_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_admin_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_admin_es");

  });
});
