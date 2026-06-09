// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_service_delivery", () => {
  it("opens and verifies screen coo_service_delivery", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/coo/service-delivery (Coo Service Delivery)...");
  cy.visitWithSemantics("/offices/corporate/roles/coo/service-delivery");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Coo Service Delivery...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooservicedelivery-screen").should("be.visible");
  cy.getCy("cooservicedelivery-title").should("be.visible");
  cy.getCy("cooservicedelivery-content").should("be.visible");
  cy.getCy("service-delivery-metrics-card").should("be.visible");
  cy.getCy("user-feedback-chart").should("be.visible");
  cy.getCy("incident-tracker").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Coo Service Delivery...");
  cy.waitAndSee();
  cy.screenshot("coo_service_delivery");
  
  cy.task("log", "✅ PROGRESS: - Verified Coo Service Delivery successfully!\n");

  });
});
