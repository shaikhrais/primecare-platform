// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - territory_sales", () => {
  it("tests all screens for role territory_sales", () => {
    cy.loginAsRole("territory_sales");


  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/marketing/roles/territory_sales_manager/dashboard (TerritorySalesManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/marketing/roles/territory_sales_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for TerritorySalesManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("territorysalesmanagerdashboard-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("territorysalesmanagerdashboard-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("territorysalesmanagerdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for TerritorySalesManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified TerritorySalesManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /management/territory-sales-manager-analytics (TerritorySalesManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/territory-sales-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for TerritorySalesManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("territorysalesmanageranalytics-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("territorysalesmanageranalytics-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("territorysalesmanageranalytics-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for TerritorySalesManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified TerritorySalesManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /management/territory-sales-manager-compliance (TerritorySalesManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/territory-sales-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for TerritorySalesManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("territorysalesmanagercompliance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("territorysalesmanagercompliance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("territorysalesmanagercompliance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for TerritorySalesManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified TerritorySalesManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /management/territory-sales-manager-workflow (TerritorySalesManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/territory-sales-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for TerritorySalesManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("territorysalesmanagerworkflow-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("territorysalesmanagerworkflow-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("territorysalesmanagerworkflow-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for TerritorySalesManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified TerritorySalesManagerWorkflowScreen successfully!\n");

  });
});
