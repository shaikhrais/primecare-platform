// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_marketing_performance_reports", () => {
  it("opens and verifies screen head_of_marketing_performance_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Head Of Marketing Performance Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Head Of Marketing Performance Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingperformancereports-screen").should("be.visible");
  cy.getCy("headofmarketingperformancereports-title").should("be.visible");
  cy.getCy("headofmarketingperformancereports-content").should("be.visible");
  cy.getCy("marketing-reports-btn-generate").should("be.visible");
  cy.getCy("marketing-btn-collaborate").should("be.visible");
  cy.getCy("marketing-btn-monitor").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Head Of Marketing Performance Reports...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_performance_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Head Of Marketing Performance Reports successfully!\n");

  });
});
