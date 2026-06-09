// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - resource_allocation_map", () => {
  it("opens and verifies screen resource_allocation_map", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Resource Allocation Map)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Resource Allocation Map...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("resourceallocationmap-screen").should("be.visible");
  cy.getCy("resourceallocationmap-title").should("be.visible");
  cy.getCy("resourceallocationmap-content").should("be.visible");
  cy.getCy("resource-allocation-refresh").should("be.visible");
  cy.getCy("resource-utilization-indicator").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Resource Allocation Map...");
  cy.waitAndSee();
  cy.screenshot("resource_allocation_map");
  
  cy.task("log", "✅ PROGRESS: - Verified Resource Allocation Map successfully!\n");

  });
});
