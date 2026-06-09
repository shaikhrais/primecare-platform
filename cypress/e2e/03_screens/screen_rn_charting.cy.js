// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_charting", () => {
  it("opens and verifies screen rn_charting", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Rn Charting)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Rn Charting...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncharting-screen").should("be.visible");
  cy.getCy("rncharting-title").should("be.visible");
  cy.getCy("rncharting-content").should("be.visible");
  cy.getCy("rn-charting-btn-submit-feedback").should("be.visible");
  cy.getCy("rn-charting-btn-report-issue").should("be.visible");
  cy.getCy("rn-charting-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Rn Charting...");
  cy.waitAndSee();
  cy.screenshot("rn_charting");
  
  cy.task("log", "✅ PROGRESS: - Verified Rn Charting successfully!\n");

  });
});
