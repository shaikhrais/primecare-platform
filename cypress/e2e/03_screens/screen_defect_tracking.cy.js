// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - defect_tracking", () => {
  it("opens and verifies screen defect_tracking", () => {
    cy.loginAsRole("qa_specialist");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/defect-tracking (DefectTrackingScreen)...");
  cy.visitWithSemantics("/staff/defect-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for DefectTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("defecttracking-screen").should("be.visible");
  cy.getCy("defecttracking-title").should("be.visible");
  cy.getCy("defecttracking-content").should("be.visible");
  cy.getCy("qa-dashboard-btn-execute-test").should("be.visible");
  cy.getCy("qa-dashboard-btn-document-defect").should("be.visible");
  cy.getCy("qa-dashboard-btn-resolve-issue").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for DefectTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("defect_tracking");
  
  cy.task("log", "✅ PROGRESS: - Verified DefectTrackingScreen successfully!\n");

  });
});
