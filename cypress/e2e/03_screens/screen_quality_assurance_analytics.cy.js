// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_assurance_analytics", () => {
  it("opens and verifies screen quality_assurance_analytics", () => {
    cy.loginAsRole("qa_specialist");

  cy.visit("/staff/quality-assurance-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassuranceanalytics-screen").should("be.visible");
  cy.getCy("qualityassuranceanalytics-title").should("be.visible");
  cy.getCy("qualityassuranceanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("quality_assurance_analytics");

  });
});
