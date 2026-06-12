// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - clinical_director", () => {
  it("tests all screens for role clinical_director", () => {
    cy.loginAsRole("clinical_director");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Navigating to /offices/clinical/roles/clinical_director/clinic-dashboard (ClinicDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Checking shell & content for ClinicDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("clinicdashboard-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicdashboard-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Saving screenshot for ClinicDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Verified ClinicDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Navigating to /offices/clinical/roles/clinical_director/analytics (ClinicalAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Checking shell & content for ClinicalAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("clinicalanalytics-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicalanalytics-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicalanalytics-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Saving screenshot for ClinicalAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Verified ClinicalAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Navigating to /offices/clinical/roles/clinical_director/compliance (ClinicalComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Checking shell & content for ClinicalComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("clinicalcompliance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicalcompliance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicalcompliance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Saving screenshot for ClinicalComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Verified ClinicalComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Navigating to /offices/clinical/roles/clinical_director/workflow (ClinicalWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Checking shell & content for ClinicalWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("clinicalworkflow-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicalworkflow-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicalworkflow-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Saving screenshot for ClinicalWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Verified ClinicalWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Navigating to /offices/clinical/roles/clinical_director/clinic-analytics (ClinicAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Checking shell & content for ClinicAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("clinicanalytics-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicanalytics-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicanalytics-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Saving screenshot for ClinicAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Verified ClinicAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Navigating to /offices/clinical/roles/clinical_director/clinic-compliance (ClinicComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Checking shell & content for ClinicComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("cliniccompliance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("cliniccompliance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("cliniccompliance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Saving screenshot for ClinicComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Verified ClinicComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Navigating to /offices/clinical/roles/clinical_director/clinic-workflow (ClinicWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Checking shell & content for ClinicWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("clinicworkflow-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicworkflow-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicworkflow-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Saving screenshot for ClinicWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Verified ClinicWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Navigating to /offices/clinical/roles/clinical_director/staff-quality (ClinicalDirectorStaffQualityScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/staff-quality");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Checking shell & content for ClinicalDirectorStaffQualityScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("clinicaldirectorstaffquality-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicaldirectorstaffquality-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicaldirectorstaffquality-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Saving screenshot for ClinicalDirectorStaffQualityScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_staff_quality");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Verified ClinicalDirectorStaffQualityScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Navigating to /offices/clinical/roles/clinical_director/incident-review (ClinicalDirectorIncidentReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/incident-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Checking shell & content for ClinicalDirectorIncidentReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("clinicaldirectorincidentreview-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicaldirectorincidentreview-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicaldirectorincidentreview-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Saving screenshot for ClinicalDirectorIncidentReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_incident_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Verified ClinicalDirectorIncidentReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Navigating to /offices/clinical/roles/clinical_director/compliance-director (ClinicalDirectorComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/compliance-director");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Checking shell & content for ClinicalDirectorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("clinicaldirectorcompliance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicaldirectorcompliance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicaldirectorcompliance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Saving screenshot for ClinicalDirectorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Verified ClinicalDirectorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Navigating to /offices/clinical/roles/clinical_director/reports (ClinicalDirectorReportsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Checking shell & content for ClinicalDirectorReportsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("clinicaldirectorreports-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicaldirectorreports-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicaldirectorreports-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Saving screenshot for ClinicalDirectorReportsScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Verified ClinicalDirectorReportsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Navigating to /offices/clinical/roles/clinical_director/approvals (ClinicalDirectorApprovalsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/approvals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Checking shell & content for ClinicalDirectorApprovalsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("clinicaldirectorapprovals-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicaldirectorapprovals-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicaldirectorapprovals-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Saving screenshot for ClinicalDirectorApprovalsScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_approvals");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Verified ClinicalDirectorApprovalsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Navigating to /offices/clinical/roles/clinical_director/performance (ClinicalDirectorPerformanceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/performance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Checking shell & content for ClinicalDirectorPerformanceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("clinicaldirectorperformance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicaldirectorperformance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicaldirectorperformance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Saving screenshot for ClinicalDirectorPerformanceScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_performance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Verified ClinicalDirectorPerformanceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Navigating to /offices/clinical/roles/clinical_director/quality (ClinicalQualityScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/quality");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Checking shell & content for ClinicalQualityScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("clinicalquality-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicalquality-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicalquality-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Saving screenshot for ClinicalQualityScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_quality");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Verified ClinicalQualityScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Navigating to /offices/clinical/roles/clinical_director/staff-performance (StaffPerformanceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/staff-performance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Checking shell & content for StaffPerformanceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("staffperformance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("staffperformance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("staffperformance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Saving screenshot for StaffPerformanceScreen...");
  cy.waitAndSee();
  cy.screenshot("staff_performance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Verified StaffPerformanceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Navigating to /offices/clinical/roles/clinical_director/compliance-review (ComplianceReviewScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/compliance-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Checking shell & content for ComplianceReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("compliancereview-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("compliancereview-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("compliancereview-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Saving screenshot for ComplianceReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Verified ComplianceReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Navigating to /offices/clinical/roles/clinical_director/incident-oversight (IncidentOversightScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/incident-oversight");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Checking shell & content for IncidentOversightScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("incidentoversight-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("incidentoversight-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("incidentoversight-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Saving screenshot for IncidentOversightScreen...");
  cy.waitAndSee();
  cy.screenshot("incident_oversight");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Verified IncidentOversightScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Navigating to /offices/clinical/roles/clinical_director/operations4k (ClinicalOperations4KScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/operations4k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Checking shell & content for ClinicalOperations4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("clinicaloperations4k-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicaloperations4k-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("clinicaloperations4k-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Saving screenshot for ClinicalOperations4KScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_operations4_k");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Verified ClinicalOperations4KScreen successfully!\n");

  });
});
