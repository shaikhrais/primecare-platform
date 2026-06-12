// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - ops_manager", () => {
  it("tests all screens for role ops_manager", () => {
    cy.loginAsRole("ops_manager");


  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/6 | 16%] - Navigating to /management/operations-manager-analytics (OperationsManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/operations-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/6 | 16%] - Checking shell & content for OperationsManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanageranalytics-screen").should("be.visible");
  cy.getCy("operationsmanageranalytics-title").should("be.visible");
  cy.getCy("operationsmanageranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/6 | 16%] - Saving screenshot for OperationsManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/6 | 16%] - Verified OperationsManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [2/6 | 33%] - Navigating to /management/operations-manager-workflow (OperationsManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/operations-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [2/6 | 33%] - Checking shell & content for OperationsManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerworkflow-screen").should("be.visible");
  cy.getCy("operationsmanagerworkflow-title").should("be.visible");
  cy.getCy("operationsmanagerworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [2/6 | 33%] - Saving screenshot for OperationsManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [2/6 | 33%] - Verified OperationsManagerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [3/6 | 50%] - Navigating to /management/daily-operations (DailyOperationsScreen)...");
  cy.visitWithSemantics("/management/daily-operations");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [3/6 | 50%] - Checking shell & content for DailyOperationsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dailyoperations-screen").should("be.visible");
  cy.getCy("dailyoperations-title").should("be.visible");
  cy.getCy("dailyoperations-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [3/6 | 50%] - Saving screenshot for DailyOperationsScreen...");
  cy.waitAndSee();
  cy.screenshot("daily_operations");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [3/6 | 50%] - Verified DailyOperationsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [4/6 | 66%] - Navigating to /management/attendance (AttendanceScreen)...");
  cy.visitWithSemantics("/management/attendance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [4/6 | 66%] - Checking shell & content for AttendanceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("attendance-screen").should("be.visible");
  cy.getCy("attendance-title").should("be.visible");
  cy.getCy("attendance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [4/6 | 66%] - Saving screenshot for AttendanceScreen...");
  cy.waitAndSee();
  cy.screenshot("attendance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [4/6 | 66%] - Verified AttendanceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [5/6 | 83%] - Navigating to /management/scheduling-health (SchedulingHealthScreen)...");
  cy.visitWithSemantics("/management/scheduling-health");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [5/6 | 83%] - Checking shell & content for SchedulingHealthScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulinghealth-screen").should("be.visible");
  cy.getCy("schedulinghealth-title").should("be.visible");
  cy.getCy("schedulinghealth-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [5/6 | 83%] - Saving screenshot for SchedulingHealthScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduling_health");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [5/6 | 83%] - Verified SchedulingHealthScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [6/6 | 100%] - Navigating to /management/service-issue (ServiceIssueScreen)...");
  cy.visitWithSemantics("/management/service-issue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [6/6 | 100%] - Checking shell & content for ServiceIssueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("serviceissue-screen").should("be.visible");
  cy.getCy("serviceissue-title").should("be.visible");
  cy.getCy("serviceissue-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [6/6 | 100%] - Saving screenshot for ServiceIssueScreen...");
  cy.waitAndSee();
  cy.screenshot("service_issue");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [6/6 | 100%] - Verified ServiceIssueScreen successfully!\n");

  });
});
