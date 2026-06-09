// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - service_mesh_topology", () => {
  it("opens and verifies screen service_mesh_topology", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Service Mesh Topology)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Service Mesh Topology...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("servicemeshtopology-screen").should("be.visible");
  cy.getCy("servicemeshtopology-title").should("be.visible");
  cy.getCy("servicemeshtopology-content").should("be.visible");
  cy.getCy("service-mesh-btn-refresh").should("be.visible");
  cy.getCy("service-mesh-error-message").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Service Mesh Topology...");
  cy.waitAndSee();
  cy.screenshot("service_mesh_topology");
  
  cy.task("log", "✅ PROGRESS: - Verified Service Mesh Topology successfully!\n");

  });
});
