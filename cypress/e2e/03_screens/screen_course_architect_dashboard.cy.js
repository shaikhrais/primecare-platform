// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - course_architect_dashboard", () => {
  it("opens and verifies screen course_architect_dashboard", () => {
    cy.loginAsRole("training_director");

  cy.visitWithSemantics("/common/course-architect-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectdashboard-screen").should("be.visible");
  cy.getCy("coursearchitectdashboard-title").should("be.visible");
  cy.getCy("coursearchitectdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_dashboard");

  });
});
