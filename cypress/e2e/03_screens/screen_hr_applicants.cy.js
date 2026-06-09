// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_applicants", () => {
  it("opens and verifies screen hr_applicants", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Hr Applicants)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Hr Applicants...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrapplicants-screen").should("be.visible");
  cy.getCy("hrapplicants-title").should("be.visible");
  cy.getCy("hrapplicants-content").should("be.visible");
  cy.getCy("hrapplicants-btn-submit-event-log").should("be.visible");
  cy.getCy("hrapplicants-btn-refresh-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Hr Applicants...");
  cy.waitAndSee();
  cy.screenshot("hr_applicants");
  
  cy.task("log", "✅ PROGRESS: - Verified Hr Applicants successfully!\n");

  });
});
