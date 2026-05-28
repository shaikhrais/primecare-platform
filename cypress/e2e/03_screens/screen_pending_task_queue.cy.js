// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - pending_task_queue", () => {
  it("opens and verifies screen pending_task_queue", () => {
    cy.loginAsRole("governance");

  cy.visitWithSemantics("/common/pending-task-queue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pendingtaskqueue-screen").should("be.visible");
  cy.getCy("pendingtaskqueue-title").should("be.visible");
  cy.getCy("pendingtaskqueue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("pending_task_queue");

  });
});
