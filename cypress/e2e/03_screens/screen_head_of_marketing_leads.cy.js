// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_marketing_leads", () => {
  it("opens and verifies screen head_of_marketing_leads", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Head Of Marketing Leads)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Head Of Marketing Leads...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingleads-screen").should("be.visible");
  cy.getCy("headofmarketingleads-title").should("be.visible");
  cy.getCy("headofmarketingleads-content").should("be.visible");
  cy.getCy("lead-status-overview").should("be.visible");
  cy.getCy("conversion-rate-metric").should("be.visible");
  cy.getCy("campaign-performance-analytics").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Head Of Marketing Leads...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_leads");
  
  cy.task("log", "✅ PROGRESS: - Verified Head Of Marketing Leads successfully!\n");

  });
});
