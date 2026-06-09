// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_outreach_reports", () => {
  it("opens and verifies screen community_outreach_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Community Outreach Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Community Outreach Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachreports-screen").should("be.visible");
  cy.getCy("communityoutreachreports-title").should("be.visible");
  cy.getCy("communityoutreachreports-content").should("be.visible");
  cy.getCy("outreach-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("outreach-dashboard-btn-download-report").should("be.visible");
  cy.getCy("outreach-dashboard-btn-submit-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Community Outreach Reports...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Community Outreach Reports successfully!\n");

  });
});
