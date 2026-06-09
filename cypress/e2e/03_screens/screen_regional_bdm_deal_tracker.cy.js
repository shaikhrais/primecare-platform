// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_deal_tracker", () => {
  it("opens and verifies screen regional_bdm_deal_tracker", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/regional_bdm/deal-tracker (Regional Bdm Deal Tracker)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_bdm/deal-tracker");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regional Bdm Deal Tracker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmdealtracker-screen").should("be.visible");
  cy.getCy("regionalbdmdealtracker-title").should("be.visible");
  cy.getCy("regionalbdmdealtracker-content").should("be.visible");
  cy.getCy("dealtracker-btn-update-status").should("be.visible");
  cy.getCy("dealtracker-btn-add-deal").should("be.visible");
  cy.getCy("dealtracker-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regional Bdm Deal Tracker...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_deal_tracker");
  
  cy.task("log", "✅ PROGRESS: - Verified Regional Bdm Deal Tracker successfully!\n");

  });
});
