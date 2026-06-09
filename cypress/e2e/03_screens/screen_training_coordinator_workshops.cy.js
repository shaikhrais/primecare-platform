// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_coordinator_workshops", () => {
  it("opens and verifies screen training_coordinator_workshops", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Training Coordinator Workshops)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Coordinator Workshops...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatorworkshops-screen").should("be.visible");
  cy.getCy("trainingcoordinatorworkshops-title").should("be.visible");
  cy.getCy("trainingcoordinatorworkshops-content").should("be.visible");
  cy.getCy("workshop-status-monitor").should("be.visible");
  cy.getCy("schedule-workshop-btn").should("be.visible");
  cy.getCy("manage-registrations-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Coordinator Workshops...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_workshops");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Coordinator Workshops successfully!\n");

  });
});
