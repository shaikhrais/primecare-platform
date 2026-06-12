// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - ops_manager", () => {
  it("tests all screens for role ops_manager", () => {
    cy.loginAsRole("ops_manager");


  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/8 | 12%] - Navigating to /offices/franchise/roles/operations_manager/dashboard (OperationsManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/operations_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/8 | 12%] - Checking shell & content for OperationsManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("operationsmanagerdashboard-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("operationsmanagerdashboard-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("operationsmanagerdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/8 | 12%] - Saving screenshot for OperationsManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/8 | 12%] - Verified OperationsManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/8 | 25%] - Navigating to /management/operations-manager-analytics (OperationsManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/operations-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/8 | 25%] - Checking shell & content for OperationsManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("operationsmanageranalytics-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("operationsmanageranalytics-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("operationsmanageranalytics-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/8 | 25%] - Saving screenshot for OperationsManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/8 | 25%] - Verified OperationsManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/8 | 37%] - Navigating to /management/operations-manager-compliance (OperationsManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/operations-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/8 | 37%] - Checking shell & content for OperationsManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("operationsmanagercompliance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("operationsmanagercompliance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("operationsmanagercompliance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/8 | 37%] - Saving screenshot for OperationsManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [3/8 | 37%] - Verified OperationsManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/8 | 50%] - Navigating to /management/operations-manager-workflow (OperationsManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/operations-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/8 | 50%] - Checking shell & content for OperationsManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("operationsmanagerworkflow-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("operationsmanagerworkflow-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("operationsmanagerworkflow-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/8 | 50%] - Saving screenshot for OperationsManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/8 | 50%] - Verified OperationsManagerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [5/8 | 62%] - Navigating to /management/daily-operations (DailyOperationsScreen)...");
  cy.visitWithSemantics("/management/daily-operations");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [5/8 | 62%] - Checking shell & content for DailyOperationsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("dailyoperations-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("dailyoperations-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("dailyoperations-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [5/8 | 62%] - Saving screenshot for DailyOperationsScreen...");
  cy.waitAndSee();
  cy.screenshot("daily_operations");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [5/8 | 62%] - Verified DailyOperationsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [6/8 | 75%] - Navigating to /management/attendance (AttendanceScreen)...");
  cy.visitWithSemantics("/management/attendance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [6/8 | 75%] - Checking shell & content for AttendanceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("attendance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("attendance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("attendance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [6/8 | 75%] - Saving screenshot for AttendanceScreen...");
  cy.waitAndSee();
  cy.screenshot("attendance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [6/8 | 75%] - Verified AttendanceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [7/8 | 87%] - Navigating to /management/scheduling-health (SchedulingHealthScreen)...");
  cy.visitWithSemantics("/management/scheduling-health");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [7/8 | 87%] - Checking shell & content for SchedulingHealthScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("schedulinghealth-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulinghealth-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("schedulinghealth-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [7/8 | 87%] - Saving screenshot for SchedulingHealthScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduling_health");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [7/8 | 87%] - Verified SchedulingHealthScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [8/8 | 100%] - Navigating to /management/service-issue (ServiceIssueScreen)...");
  cy.visitWithSemantics("/management/service-issue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [8/8 | 100%] - Checking shell & content for ServiceIssueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("serviceissue-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("serviceissue-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("serviceissue-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [8/8 | 100%] - Saving screenshot for ServiceIssueScreen...");
  cy.waitAndSee();
  cy.screenshot("service_issue");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [8/8 | 100%] - Verified ServiceIssueScreen successfully!\n");

  });
});
