// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - environmental_health_hazards", () => {
  it("opens and verifies screen environmental_health_hazards", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Environmental Health Hazards)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Environmental Health Hazards...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("environmentalhealthhazards-screen").should("be.visible");
  cy.getCy("environmentalhealthhazards-title").should("be.visible");
  cy.getCy("environmentalhealthhazards-content").should("be.visible");
  cy.getCy("ehhazards-btn-report").should("be.visible");
  cy.getCy("ehhazards-btn-update").should("be.visible");
  cy.getCy("ehhazards-btn-viewreports").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Environmental Health Hazards...");
  cy.waitAndSee();
  cy.screenshot("environmental_health_hazards");
  
  cy.task("log", "✅ PROGRESS: - Verified Environmental Health Hazards successfully!\n");

  });
});
