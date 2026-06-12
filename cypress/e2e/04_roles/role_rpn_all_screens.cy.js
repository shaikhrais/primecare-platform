// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - rpn", () => {
  it("tests all screens for role rpn", () => {
    cy.loginAsRole("rpn");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Navigating to /offices/clinical/roles/rpn/dashboard (RpnDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Checking shell & content for RpnDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("rpndashboard-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpndashboard-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpndashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Saving screenshot for RpnDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Verified RpnDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Navigating to /offices/clinical/roles/rpn/rpn-analytics (RpnAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Checking shell & content for RpnAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("rpnanalytics-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpnanalytics-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpnanalytics-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Saving screenshot for RpnAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Verified RpnAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Navigating to /offices/clinical/roles/rpn/rpn-compliance (RpnComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Checking shell & content for RpnComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("rpncompliance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpncompliance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpncompliance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Saving screenshot for RpnComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Verified RpnComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Navigating to /offices/clinical/roles/rpn/rpn-workflow (RpnWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Checking shell & content for RpnWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("rpnworkflow-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpnworkflow-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpnworkflow-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Saving screenshot for RpnWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Verified RpnWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Navigating to /offices/clinical/roles/rpn/rpn-command-center (RpnCommandCenterScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Checking shell & content for RpnCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("rpncommandcenter-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpncommandcenter-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpncommandcenter-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Saving screenshot for RpnCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_command_center");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Verified RpnCommandCenterScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Navigating to /offices/clinical/roles/rpn/patient-charting (RpnPatientChartingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/patient-charting");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Checking shell & content for RpnPatientChartingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("rpnpatientcharting-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpnpatientcharting-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpnpatientcharting-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Saving screenshot for RpnPatientChartingScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_patient_charting");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Verified RpnPatientChartingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Navigating to /offices/clinical/roles/rpn/medications (RpnMedicationsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/medications");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Checking shell & content for RpnMedicationsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("rpnmedications-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpnmedications-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpnmedications-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Saving screenshot for RpnMedicationsScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_medications");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Verified RpnMedicationsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Navigating to /offices/clinical/roles/rpn/vitals (RpnVitalsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/vitals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Checking shell & content for RpnVitalsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("rpnvitals-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpnvitals-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpnvitals-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Saving screenshot for RpnVitalsScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_vitals");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Verified RpnVitalsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Navigating to /offices/clinical/roles/rpn/rpn-care-plan-review (RpnCarePlanReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-care-plan-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Checking shell & content for RpnCarePlanReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("rpncareplanreview-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpncareplanreview-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpncareplanreview-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Saving screenshot for RpnCarePlanReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_care_plan_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Verified RpnCarePlanReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Navigating to /offices/clinical/roles/rpn/rpn-incident-review (RpnIncidentReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-incident-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Checking shell & content for RpnIncidentReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("rpnincidentreview-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpnincidentreview-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpnincidentreview-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Saving screenshot for RpnIncidentReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_incident_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Verified RpnIncidentReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Navigating to /offices/clinical/roles/rpn/rpn-tasks (RpnTasksScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-tasks");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Checking shell & content for RpnTasksScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("rpntasks-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpntasks-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpntasks-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Saving screenshot for RpnTasksScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_tasks");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Verified RpnTasksScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Navigating to /offices/clinical/roles/rpn/rpn-reports (RpnReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Checking shell & content for RpnReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("rpnreports-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpnreports-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("rpnreports-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Saving screenshot for RpnReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Verified RpnReportsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Navigating to /offices/clinical/roles/rpn/nursing-task (NursingTaskScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/nursing-task");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Checking shell & content for NursingTaskScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("nursingtask-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("nursingtask-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("nursingtask-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Saving screenshot for NursingTaskScreen...");
  cy.waitAndSee();
  cy.screenshot("nursing_task");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Verified NursingTaskScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Navigating to /offices/clinical/roles/rpn/vitals-tracking (VitalsTrackingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/vitals-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Checking shell & content for VitalsTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("vitalstracking-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("vitalstracking-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("vitalstracking-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Saving screenshot for VitalsTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("vitals_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Verified VitalsTrackingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Navigating to /offices/clinical/roles/rpn/medication (MedicationScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/medication");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Checking shell & content for MedicationScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("medication-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("medication-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("medication-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Saving screenshot for MedicationScreen...");
  cy.waitAndSee();
  cy.screenshot("medication");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Verified MedicationScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Navigating to /offices/clinical/roles/rpn/patient-observation (PatientObservationScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/patient-observation");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Checking shell & content for PatientObservationScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("patientobservation-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("patientobservation-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("patientobservation-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Saving screenshot for PatientObservationScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_observation");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Verified PatientObservationScreen successfully!\n");

  });
});
