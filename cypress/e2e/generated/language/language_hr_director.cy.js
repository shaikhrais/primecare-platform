// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - hr_director", () => {
  it("switches active languages for hr_director", () => {
    cy.loginAsRole("hr_director");

    cy.switchLanguage("en");
    cy.screenshot("language_hr_director_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_hr_director_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_hr_director_es");

  });
});
