// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - system_verification", () => {
  it("tests all screens for role system_verification", () => {
    cy.loginAsRole("system_verification");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Navigating to /offices/support/roles/quality_assurance/dashboard (QaDashboardScreen)...");
  cy.visitWithSemantics("/offices/support/roles/quality_assurance/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Checking shell & content for QaDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qadashboard-screen").should("be.visible");
  cy.getCy("qadashboard-title").should("be.visible");
  cy.getCy("qadashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Saving screenshot for QaDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("qa_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [1/3 | 33%] - Verified QaDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Navigating to packages/primecare_ui/lib/src/screens/common/system_verification_dashboard_screen.dart (SystemVerificationDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/system_verification_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Checking shell & content for SystemVerificationDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationdashboard-screen").should("be.visible");
  cy.getCy("systemverificationdashboard-title").should("be.visible");
  cy.getCy("systemverificationdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Saving screenshot for SystemVerificationDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("system_verification_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [2/3 | 66%] - Verified SystemVerificationDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Navigating to packages/primecare_ui/lib/src/screens/staff/quality_assurance_dashboard_screen.dart (QualityAssuranceDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/staff/quality_assurance_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Checking shell & content for QualityAssuranceDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancedashboard-screen").should("be.visible");
  cy.getCy("qualityassurancedashboard-title").should("be.visible");
  // cy.getCy("qualityassurancedashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Saving screenshot for QualityAssuranceDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [3/3 | 100%] - Verified QualityAssuranceDashboardScreen successfully!\n");

  });
});
