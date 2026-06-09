// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - customer_support_issue_categories", () => {
  it("opens and verifies screen customer_support_issue_categories", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Customer Support Issue Categories)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Customer Support Issue Categories...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportissuecategories-screen").should("be.visible");
  cy.getCy("customersupportissuecategories-title").should("be.visible");
  cy.getCy("customersupportissuecategories-content").should("be.visible");
  cy.getCy("support-issue-categories-overview").should("be.visible");
  cy.getCy("support-issue-metrics").should("be.visible");
  cy.getCy("support-user-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Customer Support Issue Categories...");
  cy.waitAndSee();
  cy.screenshot("customer_support_issue_categories");
  
  cy.task("log", "✅ PROGRESS: - Verified Customer Support Issue Categories successfully!\n");

  });
});
