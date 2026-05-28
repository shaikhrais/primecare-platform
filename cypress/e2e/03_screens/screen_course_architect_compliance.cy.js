// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - course_architect_compliance", () => {
  it("opens and verifies screen course_architect_compliance", () => {
    cy.loginAsRole("training_director");

  cy.visitWithSemantics("/common/course-architect-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectcompliance-screen").should("be.visible");
  cy.getCy("coursearchitectcompliance-title").should("be.visible");
  cy.getCy("coursearchitectcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_architect_compliance");

  });
});
