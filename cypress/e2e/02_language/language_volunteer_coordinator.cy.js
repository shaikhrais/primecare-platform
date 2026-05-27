// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - volunteer_coordinator", () => {
  it("switches active languages for volunteer_coordinator", () => {
    cy.loginAsRole("volunteer_coordinator");

    cy.switchLanguage("en");
    cy.screenshot("language_volunteer_coordinator_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_volunteer_coordinator_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_volunteer_coordinator_es");

  });
});
