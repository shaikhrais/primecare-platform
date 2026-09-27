// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - customer_support", () => {
  it("switches active languages for customer_support", () => {
    cy.loginAsRole("customer_support");

    cy.switchLanguage("en");
    cy.screenshot("language_customer_support_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_customer_support_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_customer_support_es");

  });
});
