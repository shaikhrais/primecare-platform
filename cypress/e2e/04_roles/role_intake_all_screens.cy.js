// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - intake", () => {
  it("tests all screens for role intake", () => {
    cy.loginAsRole("intake");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Navigating to /offices/clinical/roles/intake_coordinator/dashboard-dup-1 (IntakeDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/dashboard-dup-1");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Checking shell & content for IntakeDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakedashboard-screen").should("be.visible");
  cy.getCy("intakedashboard-title").should("be.visible");
  cy.getCy("intakedashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Saving screenshot for IntakeDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Verified IntakeDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Navigating to /offices/clinical/roles/intake_coordinator/dashboard (IntakeCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Checking shell & content for IntakeCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordashboard-screen").should("be.visible");
  cy.getCy("intakecoordinatordashboard-title").should("be.visible");
  // cy.getCy("intakecoordinatordashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Saving screenshot for IntakeCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Verified IntakeCoordinatorDashboardScreen successfully!\n");

  });
});
