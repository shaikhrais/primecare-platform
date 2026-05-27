// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - bus_dev", () => {
  it("switches active languages for bus_dev", () => {
    cy.loginAsRole("bus_dev");

    cy.switchLanguage("en");
    cy.screenshot("language_bus_dev_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_bus_dev_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_bus_dev_es");

  });
});
