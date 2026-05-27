// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - social_worker", () => {
  it("switches active languages for social_worker", () => {
    cy.loginAsRole("social_worker");

    cy.switchLanguage("en");
    cy.screenshot("language_social_worker_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_social_worker_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_social_worker_es");

  });
});
