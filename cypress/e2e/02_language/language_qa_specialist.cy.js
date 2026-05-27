// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - qa_specialist", () => {
  it("switches active languages for qa_specialist", () => {
    cy.loginAsRole("qa_specialist");

    cy.switchLanguage("en");
    cy.screenshot("language_qa_specialist_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_qa_specialist_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_qa_specialist_es");

  });
});
