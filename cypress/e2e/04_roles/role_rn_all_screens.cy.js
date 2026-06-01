// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - rn", () => {
  it("tests all screens for role rn", () => {
    cy.loginAsRole("rn");


  
  cy.checkTestRegistry("systemdashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/39 | 2%] - Navigating to /common/system-dashboard (SystemDashboardScreen)...");
    cy.visitWithSemantics("/common/system-dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/39 | 2%] - Checking shell & content for /common/system-dashboard (SystemDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("systemdashboard-screen").should("be.visible");
    cy.getCy("systemdashboard-title").should("be.visible");
    cy.getCy("systemdashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/39 | 2%] - Saving screenshot for /common/system-dashboard (SystemDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("system_dashboard");
    
    cy.updateTestRegistry("systemdashboard", "PASS", "role_rn_all_screens.cy.js", "system_dashboard");
    cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/39 | 2%] - Verified SystemDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("governanceofficerdashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/39 | 5%] - Navigating to /management/governance-officer-dashboard (GovernanceOfficerDashboardScreen)...");
    cy.visitWithSemantics("/management/governance-officer-dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/39 | 5%] - Checking shell & content for /management/governance-officer-dashboard (GovernanceOfficerDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("governanceofficerdashboard-screen").should("be.visible");
    cy.getCy("governanceofficerdashboard-title").should("be.visible");
    cy.getCy("governanceofficerdashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/39 | 5%] - Saving screenshot for /management/governance-officer-dashboard (GovernanceOfficerDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("governance_officer_dashboard");
    
    cy.updateTestRegistry("governanceofficerdashboard", "PASS", "role_rn_all_screens.cy.js", "governance_officer_dashboard");
    cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/39 | 5%] - Verified GovernanceOfficerDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rndashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/39 | 7%] - Navigating to /offices/clinical/roles/rn/dashboard (RnDashboardScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/39 | 7%] - Checking shell & content for /offices/clinical/roles/rn/dashboard (RnDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rndashboard-screen").should("be.visible");
    cy.getCy("rndashboard-title").should("be.visible");
    cy.getCy("rndashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/39 | 7%] - Saving screenshot for /offices/clinical/roles/rn/dashboard (RnDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("rn_dashboard");
    
    cy.updateTestRegistry("rndashboard", "PASS", "role_rn_all_screens.cy.js", "rn_dashboard");
    cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/39 | 7%] - Verified RnDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rnfieldsupervisordashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/39 | 10%] - Navigating to /rn/rn-field-supervisor-dashboard (RnFieldSupervisorDashboardScreen)...");
    cy.visitWithSemantics("/rn/rn-field-supervisor-dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/39 | 10%] - Checking shell & content for /rn/rn-field-supervisor-dashboard (RnFieldSupervisorDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rnfieldsupervisordashboard-screen").should("be.visible");
    cy.getCy("rnfieldsupervisordashboard-title").should("be.visible");
    cy.getCy("rnfieldsupervisordashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/39 | 10%] - Saving screenshot for /rn/rn-field-supervisor-dashboard (RnFieldSupervisorDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("rn_field_supervisor_dashboard");
    
    cy.updateTestRegistry("rnfieldsupervisordashboard", "PASS", "role_rn_all_screens.cy.js", "rn_field_supervisor_dashboard");
    cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/39 | 10%] - Verified RnFieldSupervisorDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("governanceofficeranalytics").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/39 | 12%] - Navigating to /management/governance-officer-analytics (GovernanceOfficerAnalyticsScreen)...");
    cy.visitWithSemantics("/management/governance-officer-analytics");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/39 | 12%] - Checking shell & content for /management/governance-officer-analytics (GovernanceOfficerAnalyticsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("governanceofficeranalytics-screen").should("be.visible");
    cy.getCy("governanceofficeranalytics-title").should("be.visible");
    cy.getCy("governanceofficeranalytics-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/39 | 12%] - Saving screenshot for /management/governance-officer-analytics (GovernanceOfficerAnalyticsScreen)...");
    cy.waitAndSee();
    cy.screenshot("governance_officer_analytics");
    
    cy.updateTestRegistry("governanceofficeranalytics", "PASS", "role_rn_all_screens.cy.js", "governance_officer_analytics");
    cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/39 | 12%] - Verified GovernanceOfficerAnalyticsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("governanceofficercompliance").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/39 | 15%] - Navigating to /management/governance-officer-compliance (GovernanceOfficerComplianceScreen)...");
    cy.visitWithSemantics("/management/governance-officer-compliance");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/39 | 15%] - Checking shell & content for /management/governance-officer-compliance (GovernanceOfficerComplianceScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("governanceofficercompliance-screen").should("be.visible");
    cy.getCy("governanceofficercompliance-title").should("be.visible");
    cy.getCy("governanceofficercompliance-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/39 | 15%] - Saving screenshot for /management/governance-officer-compliance (GovernanceOfficerComplianceScreen)...");
    cy.waitAndSee();
    cy.screenshot("governance_officer_compliance");
    
    cy.updateTestRegistry("governanceofficercompliance", "PASS", "role_rn_all_screens.cy.js", "governance_officer_compliance");
    cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/39 | 15%] - Verified GovernanceOfficerComplianceScreen successfully!\n");
  });


  
  cy.checkTestRegistry("governanceofficerworkflow").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/39 | 17%] - Navigating to /management/governance-officer-workflow (GovernanceOfficerWorkflowScreen)...");
    cy.visitWithSemantics("/management/governance-officer-workflow");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/39 | 17%] - Checking shell & content for /management/governance-officer-workflow (GovernanceOfficerWorkflowScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("governanceofficerworkflow-screen").should("be.visible");
    cy.getCy("governanceofficerworkflow-title").should("be.visible");
    cy.getCy("governanceofficerworkflow-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/39 | 17%] - Saving screenshot for /management/governance-officer-workflow (GovernanceOfficerWorkflowScreen)...");
    cy.waitAndSee();
    cy.screenshot("governance_officer_workflow");
    
    cy.updateTestRegistry("governanceofficerworkflow", "PASS", "role_rn_all_screens.cy.js", "governance_officer_workflow");
    cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/39 | 17%] - Verified GovernanceOfficerWorkflowScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rnanalytics").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [8/39 | 20%] - Navigating to /offices/clinical/roles/rn/rn-analytics (RnAnalyticsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/rn-analytics");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [8/39 | 20%] - Checking shell & content for /offices/clinical/roles/rn/rn-analytics (RnAnalyticsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rnanalytics-screen").should("be.visible");
    cy.getCy("rnanalytics-title").should("be.visible");
    cy.getCy("rnanalytics-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [8/39 | 20%] - Saving screenshot for /offices/clinical/roles/rn/rn-analytics (RnAnalyticsScreen)...");
    cy.waitAndSee();
    cy.screenshot("rn_analytics");
    
    cy.updateTestRegistry("rnanalytics", "PASS", "role_rn_all_screens.cy.js", "rn_analytics");
    cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [8/39 | 20%] - Verified RnAnalyticsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rnassessments").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [9/39 | 23%] - Navigating to /offices/clinical/roles/rn/rn-assessments (RnAssessmentsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/rn-assessments");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [9/39 | 23%] - Checking shell & content for /offices/clinical/roles/rn/rn-assessments (RnAssessmentsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rnassessments-screen").should("be.visible");
    cy.getCy("rnassessments-title").should("be.visible");
    cy.getCy("rnassessments-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [9/39 | 23%] - Saving screenshot for /offices/clinical/roles/rn/rn-assessments (RnAssessmentsScreen)...");
    cy.waitAndSee();
    cy.screenshot("rn_assessments");
    
    cy.updateTestRegistry("rnassessments", "PASS", "role_rn_all_screens.cy.js", "rn_assessments");
    cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [9/39 | 23%] - Verified RnAssessmentsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rncareplans").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [10/39 | 25%] - Navigating to /offices/clinical/roles/rn/rn-care-plans (RnCarePlansScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/rn-care-plans");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [10/39 | 25%] - Checking shell & content for /offices/clinical/roles/rn/rn-care-plans (RnCarePlansScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rncareplans-screen").should("be.visible");
    cy.getCy("rncareplans-title").should("be.visible");
    cy.getCy("rncareplans-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [10/39 | 25%] - Saving screenshot for /offices/clinical/roles/rn/rn-care-plans (RnCarePlansScreen)...");
    cy.waitAndSee();
    cy.screenshot("rn_care_plans");
    
    cy.updateTestRegistry("rncareplans", "PASS", "role_rn_all_screens.cy.js", "rn_care_plans");
    cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [10/39 | 25%] - Verified RnCarePlansScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rncompliance").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [11/39 | 28%] - Navigating to /offices/clinical/roles/rn/rn-compliance (RnComplianceScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/rn-compliance");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [11/39 | 28%] - Checking shell & content for /offices/clinical/roles/rn/rn-compliance (RnComplianceScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rncompliance-screen").should("be.visible");
    cy.getCy("rncompliance-title").should("be.visible");
    cy.getCy("rncompliance-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [11/39 | 28%] - Saving screenshot for /offices/clinical/roles/rn/rn-compliance (RnComplianceScreen)...");
    cy.waitAndSee();
    cy.screenshot("rn_compliance");
    
    cy.updateTestRegistry("rncompliance", "PASS", "role_rn_all_screens.cy.js", "rn_compliance");
    cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [11/39 | 28%] - Verified RnComplianceScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rnworkflow").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [12/39 | 30%] - Navigating to /offices/clinical/roles/rn/rn-workflow (RnWorkflowScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/rn-workflow");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [12/39 | 30%] - Checking shell & content for /offices/clinical/roles/rn/rn-workflow (RnWorkflowScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rnworkflow-screen").should("be.visible");
    cy.getCy("rnworkflow-title").should("be.visible");
    cy.getCy("rnworkflow-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [12/39 | 30%] - Saving screenshot for /offices/clinical/roles/rn/rn-workflow (RnWorkflowScreen)...");
    cy.waitAndSee();
    cy.screenshot("rn_workflow");
    
    cy.updateTestRegistry("rnworkflow", "PASS", "role_rn_all_screens.cy.js", "rn_workflow");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [12/39 | 30%] - Verified RnWorkflowScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rncommandcenter").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [13/39 | 33%] - Navigating to /offices/clinical/roles/rn/rn-command-center (RnCommandCenterScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/rn-command-center");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [13/39 | 33%] - Checking shell & content for /offices/clinical/roles/rn/rn-command-center (RnCommandCenterScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rncommandcenter-screen").should("be.visible");
    cy.getCy("rncommandcenter-title").should("be.visible");
    cy.getCy("rncommandcenter-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [13/39 | 33%] - Saving screenshot for /offices/clinical/roles/rn/rn-command-center (RnCommandCenterScreen)...");
    cy.waitAndSee();
    cy.screenshot("rn_command_center");
    
    cy.updateTestRegistry("rncommandcenter", "PASS", "role_rn_all_screens.cy.js", "rn_command_center");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [13/39 | 33%] - Verified RnCommandCenterScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rnpatientcharting").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [14/39 | 35%] - Navigating to /offices/clinical/roles/rn/patient-charting (RnPatientChartingScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/patient-charting");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [14/39 | 35%] - Checking shell & content for /offices/clinical/roles/rn/patient-charting (RnPatientChartingScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rnpatientcharting-screen").should("be.visible");
    cy.getCy("rnpatientcharting-title").should("be.visible");
    cy.getCy("rnpatientcharting-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [14/39 | 35%] - Saving screenshot for /offices/clinical/roles/rn/patient-charting (RnPatientChartingScreen)...");
    cy.waitAndSee();
    cy.screenshot("rn_patient_charting");
    
    cy.updateTestRegistry("rnpatientcharting", "PASS", "role_rn_all_screens.cy.js", "rn_patient_charting");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [14/39 | 35%] - Verified RnPatientChartingScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rnmedications").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [15/39 | 38%] - Navigating to /offices/clinical/roles/rn/medications (RnMedicationsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/medications");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [15/39 | 38%] - Checking shell & content for /offices/clinical/roles/rn/medications (RnMedicationsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rnmedications-screen").should("be.visible");
    cy.getCy("rnmedications-title").should("be.visible");
    cy.getCy("rnmedications-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [15/39 | 38%] - Saving screenshot for /offices/clinical/roles/rn/medications (RnMedicationsScreen)...");
    cy.waitAndSee();
    cy.screenshot("rn_medications");
    
    cy.updateTestRegistry("rnmedications", "PASS", "role_rn_all_screens.cy.js", "rn_medications");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [15/39 | 38%] - Verified RnMedicationsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rnvitals").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [16/39 | 41%] - Navigating to /offices/clinical/roles/rn/vitals (RnVitalsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/vitals");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [16/39 | 41%] - Checking shell & content for /offices/clinical/roles/rn/vitals (RnVitalsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rnvitals-screen").should("be.visible");
    cy.getCy("rnvitals-title").should("be.visible");
    cy.getCy("rnvitals-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [16/39 | 41%] - Saving screenshot for /offices/clinical/roles/rn/vitals (RnVitalsScreen)...");
    cy.waitAndSee();
    cy.screenshot("rn_vitals");
    
    cy.updateTestRegistry("rnvitals", "PASS", "role_rn_all_screens.cy.js", "rn_vitals");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [16/39 | 41%] - Verified RnVitalsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rncareplanreview").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [17/39 | 43%] - Navigating to /offices/clinical/roles/rn/rn-care-plan-review (RnCarePlanReviewScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/rn-care-plan-review");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [17/39 | 43%] - Checking shell & content for /offices/clinical/roles/rn/rn-care-plan-review (RnCarePlanReviewScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rncareplanreview-screen").should("be.visible");
    cy.getCy("rncareplanreview-title").should("be.visible");
    cy.getCy("rncareplanreview-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [17/39 | 43%] - Saving screenshot for /offices/clinical/roles/rn/rn-care-plan-review (RnCarePlanReviewScreen)...");
    cy.waitAndSee();
    cy.screenshot("rn_care_plan_review");
    
    cy.updateTestRegistry("rncareplanreview", "PASS", "role_rn_all_screens.cy.js", "rn_care_plan_review");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [17/39 | 43%] - Verified RnCarePlanReviewScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rnincidentreview").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [18/39 | 46%] - Navigating to /offices/clinical/roles/rn/rn-incident-review (RnIncidentReviewScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/rn-incident-review");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [18/39 | 46%] - Checking shell & content for /offices/clinical/roles/rn/rn-incident-review (RnIncidentReviewScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rnincidentreview-screen").should("be.visible");
    cy.getCy("rnincidentreview-title").should("be.visible");
    cy.getCy("rnincidentreview-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [18/39 | 46%] - Saving screenshot for /offices/clinical/roles/rn/rn-incident-review (RnIncidentReviewScreen)...");
    cy.waitAndSee();
    cy.screenshot("rn_incident_review");
    
    cy.updateTestRegistry("rnincidentreview", "PASS", "role_rn_all_screens.cy.js", "rn_incident_review");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [18/39 | 46%] - Verified RnIncidentReviewScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rntasks").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [19/39 | 48%] - Navigating to /offices/clinical/roles/rn/rn-tasks (RnTasksScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/rn-tasks");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [19/39 | 48%] - Checking shell & content for /offices/clinical/roles/rn/rn-tasks (RnTasksScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rntasks-screen").should("be.visible");
    cy.getCy("rntasks-title").should("be.visible");
    cy.getCy("rntasks-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [19/39 | 48%] - Saving screenshot for /offices/clinical/roles/rn/rn-tasks (RnTasksScreen)...");
    cy.waitAndSee();
    cy.screenshot("rn_tasks");
    
    cy.updateTestRegistry("rntasks", "PASS", "role_rn_all_screens.cy.js", "rn_tasks");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [19/39 | 48%] - Verified RnTasksScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rnreports").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [20/39 | 51%] - Navigating to /offices/clinical/roles/rn/rn-reports (RnReportsScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/rn-reports");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [20/39 | 51%] - Checking shell & content for /offices/clinical/roles/rn/rn-reports (RnReportsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rnreports-screen").should("be.visible");
    cy.getCy("rnreports-title").should("be.visible");
    cy.getCy("rnreports-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [20/39 | 51%] - Saving screenshot for /offices/clinical/roles/rn/rn-reports (RnReportsScreen)...");
    cy.waitAndSee();
    cy.screenshot("rn_reports");
    
    cy.updateTestRegistry("rnreports", "PASS", "role_rn_all_screens.cy.js", "rn_reports");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [20/39 | 51%] - Verified RnReportsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("medicationadministration").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [21/39 | 53%] - Navigating to /offices/clinical/roles/rn/medication-administration (MedicationAdministrationScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/medication-administration");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [21/39 | 53%] - Checking shell & content for /offices/clinical/roles/rn/medication-administration (MedicationAdministrationScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("medicationadministration-screen").should("be.visible");
    cy.getCy("medicationadministration-title").should("be.visible");
    cy.getCy("medicationadministration-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [21/39 | 53%] - Saving screenshot for /offices/clinical/roles/rn/medication-administration (MedicationAdministrationScreen)...");
    cy.waitAndSee();
    cy.screenshot("medication_administration");
    
    cy.updateTestRegistry("medicationadministration", "PASS", "role_rn_all_screens.cy.js", "medication_administration");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [21/39 | 53%] - Verified MedicationAdministrationScreen successfully!\n");
  });


  
  cy.checkTestRegistry("careplanreview").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [22/39 | 56%] - Navigating to /offices/clinical/roles/rn/care-plan-review (CarePlanReviewScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/care-plan-review");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [22/39 | 56%] - Checking shell & content for /offices/clinical/roles/rn/care-plan-review (CarePlanReviewScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("careplanreview-screen").should("be.visible");
    cy.getCy("careplanreview-title").should("be.visible");
    cy.getCy("careplanreview-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [22/39 | 56%] - Saving screenshot for /offices/clinical/roles/rn/care-plan-review (CarePlanReviewScreen)...");
    cy.waitAndSee();
    cy.screenshot("care_plan_review");
    
    cy.updateTestRegistry("careplanreview", "PASS", "role_rn_all_screens.cy.js", "care_plan_review");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [22/39 | 56%] - Verified CarePlanReviewScreen successfully!\n");
  });


  
  cy.checkTestRegistry("incidentreview").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [23/39 | 58%] - Navigating to /offices/clinical/roles/rn/incident-review (IncidentReviewScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/incident-review");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [23/39 | 58%] - Checking shell & content for /offices/clinical/roles/rn/incident-review (IncidentReviewScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("incidentreview-screen").should("be.visible");
    cy.getCy("incidentreview-title").should("be.visible");
    cy.getCy("incidentreview-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [23/39 | 58%] - Saving screenshot for /offices/clinical/roles/rn/incident-review (IncidentReviewScreen)...");
    cy.waitAndSee();
    cy.screenshot("incident_review");
    
    cy.updateTestRegistry("incidentreview", "PASS", "role_rn_all_screens.cy.js", "incident_review");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [23/39 | 58%] - Verified IncidentReviewScreen successfully!\n");
  });


  
  cy.checkTestRegistry("shiftreport").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [24/39 | 61%] - Navigating to /offices/clinical/roles/rn/shift-report (ShiftReportScreen)...");
    cy.visitWithSemantics("/offices/clinical/roles/rn/shift-report");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [24/39 | 61%] - Checking shell & content for /offices/clinical/roles/rn/shift-report (ShiftReportScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("shiftreport-screen").should("be.visible");
    cy.getCy("shiftreport-title").should("be.visible");
    cy.getCy("shiftreport-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [24/39 | 61%] - Saving screenshot for /offices/clinical/roles/rn/shift-report (ShiftReportScreen)...");
    cy.waitAndSee();
    cy.screenshot("shift_report");
    
    cy.updateTestRegistry("shiftreport", "PASS", "role_rn_all_screens.cy.js", "shift_report");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [24/39 | 61%] - Verified ShiftReportScreen successfully!\n");
  });


  
  cy.checkTestRegistry("governancecontrolroom").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [25/39 | 64%] - Navigating to /common/governance-control-room (GovernanceControlRoomScreen)...");
    cy.visitWithSemantics("/common/governance-control-room");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [25/39 | 64%] - Checking shell & content for /common/governance-control-room (GovernanceControlRoomScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("governancecontrolroom-screen").should("be.visible");
    cy.getCy("governancecontrolroom-title").should("be.visible");
    cy.getCy("governancecontrolroom-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [25/39 | 64%] - Saving screenshot for /common/governance-control-room (GovernanceControlRoomScreen)...");
    cy.waitAndSee();
    cy.screenshot("governance_control_room");
    
    cy.updateTestRegistry("governancecontrolroom", "PASS", "role_rn_all_screens.cy.js", "governance_control_room");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [25/39 | 64%] - Verified GovernanceControlRoomScreen successfully!\n");
  });


  
  cy.checkTestRegistry("runtimeverification").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [26/39 | 66%] - Navigating to /common/runtime-verification (RuntimeVerificationScreen)...");
    cy.visitWithSemantics("/common/runtime-verification");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [26/39 | 66%] - Checking shell & content for /common/runtime-verification (RuntimeVerificationScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("runtimeverification-screen").should("be.visible");
    cy.getCy("runtimeverification-title").should("be.visible");
    cy.getCy("runtimeverification-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [26/39 | 66%] - Saving screenshot for /common/runtime-verification (RuntimeVerificationScreen)...");
    cy.waitAndSee();
    cy.screenshot("runtime_verification");
    
    cy.updateTestRegistry("runtimeverification", "PASS", "role_rn_all_screens.cy.js", "runtime_verification");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [26/39 | 66%] - Verified RuntimeVerificationScreen successfully!\n");
  });


  
  cy.checkTestRegistry("driftfindings").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [27/39 | 69%] - Navigating to /common/drift-findings (DriftFindingsScreen)...");
    cy.visitWithSemantics("/common/drift-findings");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [27/39 | 69%] - Checking shell & content for /common/drift-findings (DriftFindingsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("driftfindings-screen").should("be.visible");
    cy.getCy("driftfindings-title").should("be.visible");
    cy.getCy("driftfindings-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [27/39 | 69%] - Saving screenshot for /common/drift-findings (DriftFindingsScreen)...");
    cy.waitAndSee();
    cy.screenshot("drift_findings");
    
    cy.updateTestRegistry("driftfindings", "PASS", "role_rn_all_screens.cy.js", "drift_findings");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [27/39 | 69%] - Verified DriftFindingsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("pendingtaskqueue").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [28/39 | 71%] - Navigating to /common/pending-task-queue (PendingTaskQueueScreen)...");
    cy.visitWithSemantics("/common/pending-task-queue");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [28/39 | 71%] - Checking shell & content for /common/pending-task-queue (PendingTaskQueueScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("pendingtaskqueue-screen").should("be.visible");
    cy.getCy("pendingtaskqueue-title").should("be.visible");
    cy.getCy("pendingtaskqueue-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [28/39 | 71%] - Saving screenshot for /common/pending-task-queue (PendingTaskQueueScreen)...");
    cy.waitAndSee();
    cy.screenshot("pending_task_queue");
    
    cy.updateTestRegistry("pendingtaskqueue", "PASS", "role_rn_all_screens.cy.js", "pending_task_queue");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [28/39 | 71%] - Verified PendingTaskQueueScreen successfully!\n");
  });


  
  cy.checkTestRegistry("agentdispatch").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [29/39 | 74%] - Navigating to /common/agent-dispatch (AgentDispatchScreen)...");
    cy.visitWithSemantics("/common/agent-dispatch");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [29/39 | 74%] - Checking shell & content for /common/agent-dispatch (AgentDispatchScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("agentdispatch-screen").should("be.visible");
    cy.getCy("agentdispatch-title").should("be.visible");
    cy.getCy("agentdispatch-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [29/39 | 74%] - Saving screenshot for /common/agent-dispatch (AgentDispatchScreen)...");
    cy.waitAndSee();
    cy.screenshot("agent_dispatch");
    
    cy.updateTestRegistry("agentdispatch", "PASS", "role_rn_all_screens.cy.js", "agent_dispatch");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [29/39 | 74%] - Verified AgentDispatchScreen successfully!\n");
  });


  
  cy.checkTestRegistry("audit").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [30/39 | 76%] - Navigating to /common/audit (ScreenAuditScreen)...");
    cy.visitWithSemantics("/common/audit");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [30/39 | 76%] - Checking shell & content for /common/audit (ScreenAuditScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("audit-screen").should("be.visible");
    cy.getCy("audit-title").should("be.visible");
    cy.getCy("audit-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [30/39 | 76%] - Saving screenshot for /common/audit (ScreenAuditScreen)...");
    cy.waitAndSee();
    cy.screenshot("audit");
    
    cy.updateTestRegistry("audit", "PASS", "role_rn_all_screens.cy.js", "audit");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [30/39 | 76%] - Verified ScreenAuditScreen successfully!\n");
  });


  
  cy.checkTestRegistry("apihealthdashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [31/39 | 79%] - Navigating to /common/api-health-dashboard (ApiHealthDashboardScreen)...");
    cy.visitWithSemantics("/common/api-health-dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [31/39 | 79%] - Checking shell & content for /common/api-health-dashboard (ApiHealthDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("apihealthdashboard-screen").should("be.visible");
    cy.getCy("apihealthdashboard-title").should("be.visible");
    cy.getCy("apihealthdashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [31/39 | 79%] - Saving screenshot for /common/api-health-dashboard (ApiHealthDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("api_health_dashboard");
    
    cy.updateTestRegistry("apihealthdashboard", "PASS", "role_rn_all_screens.cy.js", "api_health_dashboard");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [31/39 | 79%] - Verified ApiHealthDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("releaseoperations").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [32/39 | 82%] - Navigating to /common/release-operations (ReleaseOperationsScreen)...");
    cy.visitWithSemantics("/common/release-operations");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [32/39 | 82%] - Checking shell & content for /common/release-operations (ReleaseOperationsScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("releaseoperations-screen").should("be.visible");
    cy.getCy("releaseoperations-title").should("be.visible");
    cy.getCy("releaseoperations-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [32/39 | 82%] - Saving screenshot for /common/release-operations (ReleaseOperationsScreen)...");
    cy.waitAndSee();
    cy.screenshot("release_operations");
    
    cy.updateTestRegistry("releaseoperations", "PASS", "role_rn_all_screens.cy.js", "release_operations");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [32/39 | 82%] - Verified ReleaseOperationsScreen successfully!\n");
  });


  
  cy.checkTestRegistry("fileverificationdashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [33/39 | 84%] - Navigating to /common/file-verification-dashboard (FileVerificationDashboardScreen)...");
    cy.visitWithSemantics("/common/file-verification-dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [33/39 | 84%] - Checking shell & content for /common/file-verification-dashboard (FileVerificationDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("fileverificationdashboard-screen").should("be.visible");
    cy.getCy("fileverificationdashboard-title").should("be.visible");
    cy.getCy("fileverificationdashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [33/39 | 84%] - Saving screenshot for /common/file-verification-dashboard (FileVerificationDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("file_verification_dashboard");
    
    cy.updateTestRegistry("fileverificationdashboard", "PASS", "role_rn_all_screens.cy.js", "file_verification_dashboard");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [33/39 | 84%] - Verified FileVerificationDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("rolecoveragedashboard").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [34/39 | 87%] - Navigating to /common/role-coverage-dashboard (RoleCoverageDashboardScreen)...");
    cy.visitWithSemantics("/common/role-coverage-dashboard");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [34/39 | 87%] - Checking shell & content for /common/role-coverage-dashboard (RoleCoverageDashboardScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("rolecoveragedashboard-screen").should("be.visible");
    cy.getCy("rolecoveragedashboard-title").should("be.visible");
    cy.getCy("rolecoveragedashboard-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [34/39 | 87%] - Saving screenshot for /common/role-coverage-dashboard (RoleCoverageDashboardScreen)...");
    cy.waitAndSee();
    cy.screenshot("role_coverage_dashboard");
    
    cy.updateTestRegistry("rolecoveragedashboard", "PASS", "role_rn_all_screens.cy.js", "role_coverage_dashboard");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [34/39 | 87%] - Verified RoleCoverageDashboardScreen successfully!\n");
  });


  
  cy.checkTestRegistry("responsivepreview").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [35/39 | 89%] - Navigating to /common/responsive-preview (ResponsivePreviewScreen)...");
    cy.visitWithSemantics("/common/responsive-preview");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [35/39 | 89%] - Checking shell & content for /common/responsive-preview (ResponsivePreviewScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("responsivepreview-screen").should("be.visible");
    cy.getCy("responsivepreview-title").should("be.visible");
    cy.getCy("responsivepreview-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [35/39 | 89%] - Saving screenshot for /common/responsive-preview (ResponsivePreviewScreen)...");
    cy.waitAndSee();
    cy.screenshot("responsive_preview");
    
    cy.updateTestRegistry("responsivepreview", "PASS", "role_rn_all_screens.cy.js", "responsive_preview");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [35/39 | 89%] - Verified ResponsivePreviewScreen successfully!\n");
  });


  
  cy.checkTestRegistry("workflowexecution").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [36/39 | 92%] - Navigating to /common/workflow-execution (WorkflowExecutionScreen)...");
    cy.visitWithSemantics("/common/workflow-execution");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [36/39 | 92%] - Checking shell & content for /common/workflow-execution (WorkflowExecutionScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("workflowexecution-screen").should("be.visible");
    cy.getCy("workflowexecution-title").should("be.visible");
    cy.getCy("workflowexecution-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [36/39 | 92%] - Saving screenshot for /common/workflow-execution (WorkflowExecutionScreen)...");
    cy.waitAndSee();
    cy.screenshot("workflow_execution");
    
    cy.updateTestRegistry("workflowexecution", "PASS", "role_rn_all_screens.cy.js", "workflow_execution");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [36/39 | 92%] - Verified WorkflowExecutionScreen successfully!\n");
  });


  
  cy.checkTestRegistry("governanceoperations4k").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [37/39 | 94%] - Navigating to /common/governance-operations4-k (GovernanceOperations4KScreen)...");
    cy.visitWithSemantics("/common/governance-operations4-k");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [37/39 | 94%] - Checking shell & content for /common/governance-operations4-k (GovernanceOperations4KScreen)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("governanceoperations4k-screen").should("be.visible");
    cy.getCy("governanceoperations4k-title").should("be.visible");
    cy.getCy("governanceoperations4k-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [37/39 | 94%] - Saving screenshot for /common/governance-operations4-k (GovernanceOperations4KScreen)...");
    cy.waitAndSee();
    cy.screenshot("governance_operations4_k");
    
    cy.updateTestRegistry("governanceoperations4k", "PASS", "role_rn_all_screens.cy.js", "governance_operations4_k");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [37/39 | 94%] - Verified GovernanceOperations4KScreen successfully!\n");
  });


  
  cy.checkTestRegistry("registered nurse (rn) field supervisor analytics").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [38/39 | 97%] - Navigating to /rn/rn-field-supervisor-analytics (Registered Nurse (RN) Field Supervisor Analytics)...");
    cy.visitWithSemantics("/rn/rn-field-supervisor-analytics");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [38/39 | 97%] - Checking shell & content for /rn/rn-field-supervisor-analytics (Registered Nurse (RN) Field Supervisor Analytics)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("registered nurse (rn) field supervisor analytics-screen").should("be.visible");
    cy.getCy("registered nurse (rn) field supervisor analytics-title").should("be.visible");
    cy.getCy("registered nurse (rn) field supervisor analytics-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [38/39 | 97%] - Saving screenshot for /rn/rn-field-supervisor-analytics (Registered Nurse (RN) Field Supervisor Analytics)...");
    cy.waitAndSee();
    cy.screenshot("rn_field_supervisor_analytics");
    
    cy.updateTestRegistry("registered nurse (rn) field supervisor analytics", "PASS", "role_rn_all_screens.cy.js", "rn_field_supervisor_analytics");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [38/39 | 97%] - Verified Registered Nurse (RN) Field Supervisor Analytics successfully!\n");
  });


  
  cy.checkTestRegistry("registered nurse (rn) field supervisor compliance workflow").then((shouldSkip) => {
    if (shouldSkip) return;

    cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [39/39 | 100%] - Navigating to /rn/rn-field-supervisor-workflow (Registered Nurse (RN) Field Supervisor Compliance Workflow)...");
    cy.visitWithSemantics("/rn/rn-field-supervisor-workflow");
    cy.waitAndSee();
    
    cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [39/39 | 100%] - Checking shell & content for /rn/rn-field-supervisor-workflow (Registered Nurse (RN) Field Supervisor Compliance Workflow)...");
    cy.verifyShellExists();
    cy.verifyNotBlank();

    cy.getCy("registered nurse (rn) field supervisor compliance workflow-screen").should("be.visible");
    cy.getCy("registered nurse (rn) field supervisor compliance workflow-title").should("be.visible");
    cy.getCy("registered nurse (rn) field supervisor compliance workflow-content").should("be.visible");

    cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [39/39 | 100%] - Saving screenshot for /rn/rn-field-supervisor-workflow (Registered Nurse (RN) Field Supervisor Compliance Workflow)...");
    cy.waitAndSee();
    cy.screenshot("rn_field_supervisor_workflow");
    
    cy.updateTestRegistry("registered nurse (rn) field supervisor compliance workflow", "PASS", "role_rn_all_screens.cy.js", "rn_field_supervisor_workflow");
    cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [39/39 | 100%] - Verified Registered Nurse (RN) Field Supervisor Compliance Workflow successfully!\n");
  });


  });
});
