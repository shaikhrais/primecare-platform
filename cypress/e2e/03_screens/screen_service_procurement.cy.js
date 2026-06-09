// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - service_procurement", () => {
  it("opens and verifies screen service_procurement", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Service Procurement)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Service Procurement...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("serviceprocurement-screen").should("be.visible");
  cy.getCy("serviceprocurement-title").should("be.visible");
  cy.getCy("serviceprocurement-content").should("be.visible");
  cy.getCy("procurement-btn-submit").should("be.visible");
  cy.getCy("procurement-btn-approve").should("be.visible");
  cy.getCy("procurement-btn-update-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Service Procurement...");
  cy.waitAndSee();
  cy.screenshot("service_procurement");
  
  cy.task("log", "✅ PROGRESS: - Verified Service Procurement successfully!\n");

  });
});
