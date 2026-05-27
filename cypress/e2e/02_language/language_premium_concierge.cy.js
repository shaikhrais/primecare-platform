// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - premium_concierge", () => {
  it("switches active languages for premium_concierge", () => {
    cy.loginAsRole("premium_concierge");

    cy.switchLanguage("en");
    cy.screenshot("language_premium_concierge_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_premium_concierge_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_premium_concierge_es");

  });
});
