// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - guest", () => {
  it("switches active languages for guest", () => {
    cy.loginAsRole("guest");

    cy.switchLanguage("en");
    cy.screenshot("language_guest_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_guest_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_guest_es");

  });
});
