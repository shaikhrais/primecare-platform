// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - policy_exception_tracker", () => {
  it("opens and verifies screen policy_exception_tracker", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Policy Exception Tracker)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Policy Exception Tracker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("policyexceptiontracker-screen").should("be.visible");
  cy.getCy("policyexceptiontracker-title").should("be.visible");
  cy.getCy("policyexceptiontracker-content").should("be.visible");
  cy.getCy("policy-exemption-refresh").should("be.visible");
  cy.getCy("policy-exemption-revoke").should("be.visible");
  cy.getCy("policy-exemption-extend").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Policy Exception Tracker...");
  cy.waitAndSee();
  cy.screenshot("policy_exception_tracker");
  
  cy.task("log", "✅ PROGRESS: - Verified Policy Exception Tracker successfully!\n");

  });
});
