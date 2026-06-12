// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - dynamic", () => {
  it("tests all screens for role dynamic", () => {
    cy.loginAsRole("dynamic");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Navigating to packages/primecare_ui/lib/src/screens/common/customer_support_dashboard_screen.dart (CustomerSupportDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/customer_support_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Checking shell & content for CustomerSupportDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportdashboard-screen").should("be.visible");
  cy.getCy("customersupportdashboard-title").should("be.visible");
  cy.getCy("customersupportdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Saving screenshot for CustomerSupportDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("customer_support_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [1/2 | 50%] - Verified CustomerSupportDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Navigating to packages/primecare_ui/lib/src/screens/common/support_dashboard_screen.dart (SupportDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/support_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Checking shell & content for SupportDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportdashboard-screen").should("be.visible");
  cy.getCy("supportdashboard-title").should("be.visible");
  cy.getCy("supportdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Saving screenshot for SupportDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("support_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [2/2 | 100%] - Verified SupportDashboardScreen successfully!\n");

  });
});
