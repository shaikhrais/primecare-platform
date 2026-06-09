// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_marketing_content_approval", () => {
  it("opens and verifies screen head_of_marketing_content_approval", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Head Of Marketing Content Approval)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Head Of Marketing Content Approval...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingcontentapproval-screen").should("be.visible");
  cy.getCy("headofmarketingcontentapproval-title").should("be.visible");
  cy.getCy("content-approval-list").should("be.visible");
  cy.getCy("approval-metrics-card").should("be.visible");
  cy.getCy("feedback-section").should("be.visible");
  cy.getCy("collaboration-tool").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Head Of Marketing Content Approval...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_content_approval");
  
  cy.task("log", "✅ PROGRESS: - Verified Head Of Marketing Content Approval successfully!\n");

  });
});
