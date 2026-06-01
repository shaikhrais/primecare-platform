// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - rpn", () => {
  it("tests all screens for role rpn", () => {
    cy.loginAsRole("rpn");


  
  cy.checkTestRegistry("rpndashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Navigating to /offices/clinical/roles/rpn/dashboard (RpnDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Checking shell & content for /offices/clinical/roles/rpn/dashboard (RpnDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rpndashboard-screen").should("be.visible");
    cy.getCy("rpndashboard-title").should("be.visible");
    cy.getCy("rpndashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Saving screenshot for /offices/clinical/roles/rpn/dashboard (RpnDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("rpn_dashboard");
    
    cy.updateTestRegistry("rpndashboard", "PASS", "role_rpn_all_screens.cy.js", "rpn_dashboard");
    cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Verified RpnDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rpnanalytics").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Navigating to /offices/clinical/roles/rpn/rpn-analytics (RpnAnalyticsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-analytics");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Checking shell & content for /offices/clinical/roles/rpn/rpn-analytics (RpnAnalyticsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rpnanalytics-screen").should("be.visible");
    cy.getCy("rpnanalytics-title").should("be.visible");
    cy.getCy("rpnanalytics-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Saving screenshot for /offices/clinical/roles/rpn/rpn-analytics (RpnAnalyticsScreen)...");
    cy.waitAndSee();
    cy.screenshot("rpn_analytics");
    
    cy.updateTestRegistry("rpnanalytics", "PASS", "role_rpn_all_screens.cy.js", "rpn_analytics");
    cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Verified RpnAnalyticsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rpncompliance").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Navigating to /offices/clinical/roles/rpn/rpn-compliance (RpnComplianceScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-compliance");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Checking shell & content for /offices/clinical/roles/rpn/rpn-compliance (RpnComplianceScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rpncompliance-screen").should("be.visible");
    cy.getCy("rpncompliance-title").should("be.visible");
    cy.getCy("rpncompliance-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Saving screenshot for /offices/clinical/roles/rpn/rpn-compliance (RpnComplianceScreen)...");
    cy.waitAndSee();
    cy.screenshot("rpn_compliance");
    
    cy.updateTestRegistry("rpncompliance", "PASS", "role_rpn_all_screens.cy.js", "rpn_compliance");
    cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Verified RpnComplianceScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rpnworkflow").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Navigating to /offices/clinical/roles/rpn/rpn-workflow (RpnWorkflowScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-workflow");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Checking shell & content for /offices/clinical/roles/rpn/rpn-workflow (RpnWorkflowScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rpnworkflow-screen").should("be.visible");
    cy.getCy("rpnworkflow-title").should("be.visible");
    cy.getCy("rpnworkflow-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Saving screenshot for /offices/clinical/roles/rpn/rpn-workflow (RpnWorkflowScreen)...");
    cy.waitAndSee();
    cy.screenshot("rpn_workflow");
    
    cy.updateTestRegistry("rpnworkflow", "PASS", "role_rpn_all_screens.cy.js", "rpn_workflow");
    cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Verified RpnWorkflowScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rpncommandcenter").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Navigating to /offices/clinical/roles/rpn/rpn-command-center (RpnCommandCenterScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-command-center");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Checking shell & content for /offices/clinical/roles/rpn/rpn-command-center (RpnCommandCenterScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rpncommandcenter-screen").should("be.visible");
    cy.getCy("rpncommandcenter-title").should("be.visible");
    cy.getCy("rpncommandcenter-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Saving screenshot for /offices/clinical/roles/rpn/rpn-command-center (RpnCommandCenterScreen)...");
    cy.waitAndSee();
    cy.screenshot("rpn_command_center");
    
    cy.updateTestRegistry("rpncommandcenter", "PASS", "role_rpn_all_screens.cy.js", "rpn_command_center");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Verified RpnCommandCenterScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rpnpatientcharting").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Navigating to /offices/clinical/roles/rpn/patient-charting (RpnPatientChartingScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/patient-charting");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Checking shell & content for /offices/clinical/roles/rpn/patient-charting (RpnPatientChartingScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rpnpatientcharting-screen").should("be.visible");
    cy.getCy("rpnpatientcharting-title").should("be.visible");
    cy.getCy("rpnpatientcharting-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Saving screenshot for /offices/clinical/roles/rpn/patient-charting (RpnPatientChartingScreen)...");
    cy.waitAndSee();
    cy.screenshot("rpn_patient_charting");
    
    cy.updateTestRegistry("rpnpatientcharting", "PASS", "role_rpn_all_screens.cy.js", "rpn_patient_charting");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Verified RpnPatientChartingScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rpnmedications").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Navigating to /offices/clinical/roles/rpn/medications (RpnMedicationsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/medications");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Checking shell & content for /offices/clinical/roles/rpn/medications (RpnMedicationsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rpnmedications-screen").should("be.visible");
    cy.getCy("rpnmedications-title").should("be.visible");
    cy.getCy("rpnmedications-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Saving screenshot for /offices/clinical/roles/rpn/medications (RpnMedicationsScreen)...");
    cy.waitAndSee();
    cy.screenshot("rpn_medications");
    
    cy.updateTestRegistry("rpnmedications", "PASS", "role_rpn_all_screens.cy.js", "rpn_medications");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Verified RpnMedicationsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rpnvitals").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Navigating to /offices/clinical/roles/rpn/vitals (RpnVitalsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/vitals");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Checking shell & content for /offices/clinical/roles/rpn/vitals (RpnVitalsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rpnvitals-screen").should("be.visible");
    cy.getCy("rpnvitals-title").should("be.visible");
    cy.getCy("rpnvitals-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Saving screenshot for /offices/clinical/roles/rpn/vitals (RpnVitalsScreen)...");
    cy.waitAndSee();
    cy.screenshot("rpn_vitals");
    
    cy.updateTestRegistry("rpnvitals", "PASS", "role_rpn_all_screens.cy.js", "rpn_vitals");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Verified RpnVitalsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rpncareplanreview").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Navigating to /offices/clinical/roles/rpn/rpn-care-plan-review (RpnCarePlanReviewScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-care-plan-review");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Checking shell & content for /offices/clinical/roles/rpn/rpn-care-plan-review (RpnCarePlanReviewScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rpncareplanreview-screen").should("be.visible");
    cy.getCy("rpncareplanreview-title").should("be.visible");
    cy.getCy("rpncareplanreview-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Saving screenshot for /offices/clinical/roles/rpn/rpn-care-plan-review (RpnCarePlanReviewScreen)...");
    cy.waitAndSee();
    cy.screenshot("rpn_care_plan_review");
    
    cy.updateTestRegistry("rpncareplanreview", "PASS", "role_rpn_all_screens.cy.js", "rpn_care_plan_review");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Verified RpnCarePlanReviewScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rpnincidentreview").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Navigating to /offices/clinical/roles/rpn/rpn-incident-review (RpnIncidentReviewScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-incident-review");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Checking shell & content for /offices/clinical/roles/rpn/rpn-incident-review (RpnIncidentReviewScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rpnincidentreview-screen").should("be.visible");
    cy.getCy("rpnincidentreview-title").should("be.visible");
    cy.getCy("rpnincidentreview-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Saving screenshot for /offices/clinical/roles/rpn/rpn-incident-review (RpnIncidentReviewScreen)...");
    cy.waitAndSee();
    cy.screenshot("rpn_incident_review");
    
    cy.updateTestRegistry("rpnincidentreview", "PASS", "role_rpn_all_screens.cy.js", "rpn_incident_review");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Verified RpnIncidentReviewScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rpntasks").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Navigating to /offices/clinical/roles/rpn/rpn-tasks (RpnTasksScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-tasks");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Checking shell & content for /offices/clinical/roles/rpn/rpn-tasks (RpnTasksScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rpntasks-screen").should("be.visible");
    cy.getCy("rpntasks-title").should("be.visible");
    cy.getCy("rpntasks-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Saving screenshot for /offices/clinical/roles/rpn/rpn-tasks (RpnTasksScreen)...");
    cy.waitAndSee();
    cy.screenshot("rpn_tasks");
    
    cy.updateTestRegistry("rpntasks", "PASS", "role_rpn_all_screens.cy.js", "rpn_tasks");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Verified RpnTasksScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rpnreports").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Navigating to /offices/clinical/roles/rpn/rpn-reports (RpnReportsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-reports");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Checking shell & content for /offices/clinical/roles/rpn/rpn-reports (RpnReportsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rpnreports-screen").should("be.visible");
    cy.getCy("rpnreports-title").should("be.visible");
    cy.getCy("rpnreports-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Saving screenshot for /offices/clinical/roles/rpn/rpn-reports (RpnReportsScreen)...");
    cy.waitAndSee();
    cy.screenshot("rpn_reports");
    
    cy.updateTestRegistry("rpnreports", "PASS", "role_rpn_all_screens.cy.js", "rpn_reports");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Verified RpnReportsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("nursingtask").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Navigating to /offices/clinical/roles/rpn/nursing-task (NursingTaskScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/nursing-task");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Checking shell & content for /offices/clinical/roles/rpn/nursing-task (NursingTaskScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("nursingtask-screen").should("be.visible");
    cy.getCy("nursingtask-title").should("be.visible");
    cy.getCy("nursingtask-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Saving screenshot for /offices/clinical/roles/rpn/nursing-task (NursingTaskScreen)...");
    cy.waitAndSee();
    cy.screenshot("nursing_task");
    
    cy.updateTestRegistry("nursingtask", "PASS", "role_rpn_all_screens.cy.js", "nursing_task");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Verified NursingTaskScreen successfully!\n");
  });


  
  cy.checkTestRegistry("vitalstracking").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Navigating to /offices/clinical/roles/rpn/vitals-tracking (VitalsTrackingScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/vitals-tracking");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Checking shell & content for /offices/clinical/roles/rpn/vitals-tracking (VitalsTrackingScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("vitalstracking-screen").should("be.visible");
    cy.getCy("vitalstracking-title").should("be.visible");
    cy.getCy("vitalstracking-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Saving screenshot for /offices/clinical/roles/rpn/vitals-tracking (VitalsTrackingScreen)...");
    cy.waitAndSee();
    cy.screenshot("vitals_tracking");
    
    cy.updateTestRegistry("vitalstracking", "PASS", "role_rpn_all_screens.cy.js", "vitals_tracking");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Verified VitalsTrackingScreen successfully!\n");
  });


  
  cy.checkTestRegistry("medication").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Navigating to /offices/clinical/roles/rpn/medication (MedicationScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/medication");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Checking shell & content for /offices/clinical/roles/rpn/medication (MedicationScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("medication-screen").should("be.visible");
    cy.getCy("medication-title").should("be.visible");
    cy.getCy("medication-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Saving screenshot for /offices/clinical/roles/rpn/medication (MedicationScreen)...");
    cy.waitAndSee();
    cy.screenshot("medication");
    
    cy.updateTestRegistry("medication", "PASS", "role_rpn_all_screens.cy.js", "medication");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Verified MedicationScreen successfully!\n");
  });


  
  cy.checkTestRegistry("patientobservation").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Navigating to /offices/clinical/roles/rpn/patient-observation (PatientObservationScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rpn/patient-observation");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Checking shell & content for /offices/clinical/roles/rpn/patient-observation (PatientObservationScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("patientobservation-screen").should("be.visible");
    cy.getCy("patientobservation-title").should("be.visible");
    cy.getCy("patientobservation-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Saving screenshot for /offices/clinical/roles/rpn/patient-observation (PatientObservationScreen)...");
    cy.waitAndSee();
    cy.screenshot("patient_observation");
    
    cy.updateTestRegistry("patientobservation", "PASS", "role_rpn_all_screens.cy.js", "patient_observation");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Verified PatientObservationScreen successfully!\n");
  });


  });
});
