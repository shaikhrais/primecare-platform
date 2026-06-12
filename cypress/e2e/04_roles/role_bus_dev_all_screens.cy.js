// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - bus_dev", () => {
  it("tests all screens for role bus_dev", () => {
    cy.loginAsRole("bus_dev");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Navigating to packages/primecare_ui/lib/src/screens/common/business_development_dashboard_screen.dart (BusinessDevelopmentDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/business_development_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Checking shell & content for BusinessDevelopmentDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentdashboard-screen").should("be.visible");
  cy.getCy("businessdevelopmentdashboard-title").should("be.visible");
  cy.getCy("businessdevelopmentdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Saving screenshot for BusinessDevelopmentDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("business_development_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Verified BusinessDevelopmentDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Navigating to /offices/corporate/roles/head_of_bus_dev/dashboard (HeadOfBusDevDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/head_of_bus_dev/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Checking shell & content for HeadOfBusDevDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevdashboard-screen").should("be.visible");
  cy.getCy("headofbusdevdashboard-title").should("be.visible");
  cy.getCy("headofbusdevdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Saving screenshot for HeadOfBusDevDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Verified HeadOfBusDevDashboardScreen successfully!\n");

  });
});
