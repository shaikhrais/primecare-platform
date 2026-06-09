// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_new_intakes", () => {
  it("opens and verifies screen intake_coordinator_new_intakes", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Intake Coordinator New Intakes)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Intake Coordinator New Intakes...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatornewintakes-screen").should("be.visible");
  cy.getCy("intakecoordinatornewintakes-title").should("be.visible");
  cy.getCy("intakecoordinatornewintakes-content").should("be.visible");
  cy.getCy("intake-monitor").should("be.visible");
  cy.getCy("intake-validate").should("be.visible");
  cy.getCy("intake-communicate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Intake Coordinator New Intakes...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_new_intakes");
  
  cy.task("log", "✅ PROGRESS: - Verified Intake Coordinator New Intakes successfully!\n");

  });
});
