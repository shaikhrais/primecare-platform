// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - course_architect_analytics", () => {
  it("opens and verifies screen course_architect_analytics", () => {
    cy.loginAsRole("training_director");

  cy.visitWithSemantics("/common/course-architect-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectanalytics-screen").should("be.visible");
  cy.getCy("coursearchitectanalytics-title").should("be.visible");
  cy.getCy("coursearchitectanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_analytics");

  });
});
