// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - hr_hiring", () => {
  it("switches active languages for hr_hiring", () => {
    cy.loginAsRole("hr_hiring");

    cy.switchLanguage("en");
    cy.screenshot("language_hr_hiring_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_hr_hiring_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_hr_hiring_es");

  });
});
