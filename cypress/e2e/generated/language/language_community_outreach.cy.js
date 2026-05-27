// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Language - community_outreach", () => {
  it("switches active languages for community_outreach", () => {
    cy.loginAsRole("community_outreach");

    cy.switchLanguage("en");
    cy.screenshot("language_community_outreach_en");

    cy.switchLanguage("fr");
    cy.screenshot("language_community_outreach_fr");

    cy.switchLanguage("es");
    cy.screenshot("language_community_outreach_es");

  });
});
