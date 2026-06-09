// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - staff_training_matrix", () => {
  it("opens and verifies screen staff_training_matrix", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Staff Training Matrix)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Staff Training Matrix...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("stafftrainingmatrix-screen").should("be.visible");
  cy.getCy("stafftrainingmatrix-title").should("be.visible");
  cy.getCy("stafftrainingmatrix-content").should("be.visible");
  cy.getCy("staff-training-matrix-overview").should("be.visible");
  cy.getCy("staff-training-update-records").should("be.visible");
  cy.getCy("staff-training-report-issue").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Staff Training Matrix...");
  cy.waitAndSee();
  cy.screenshot("staff_training_matrix");
  
  cy.task("log", "✅ PROGRESS: - Verified Staff Training Matrix successfully!\n");

  });
});
