// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - xray_review", () => {
  it("opens and verifies screen xray_review", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/chiropractor/xray-review (XrayReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/xray-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for XrayReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("xrayreview-screen").should("be.visible");
  cy.getCy("xrayreview-title").should("be.visible");
  cy.getCy("xrayreview-content").should("be.visible");
  cy.getCy("xrayreview-btn-save").should("be.visible");
  cy.getCy("xrayreview-btn-review").should("be.visible");
  cy.getCy("xrayreview-btn-logprogress").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for XrayReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("xray_review");
  
  cy.task("log", "✅ PROGRESS: - Verified XrayReviewScreen successfully!\n");

  });
});
