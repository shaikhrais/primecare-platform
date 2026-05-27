// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - vip_manager", () => {
  it("switches active languages for vip_manager", () => {
    cy.loginAsRole("vip_manager");

    cy.switchLanguage("en");
    cy.screenshot("language_vip_manager_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_vip_manager_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_vip_manager_es");

  });
});
