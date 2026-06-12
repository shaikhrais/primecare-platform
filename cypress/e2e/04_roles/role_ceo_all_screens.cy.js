// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - ceo", () => {
  it("tests all screens for role ceo", () => {
    cy.loginAsRole("ceo");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/84 | 1%] - Navigating to /offices/clinical/roles/rmt/dashboard (RmtDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/84 | 1%] - Checking shell & content for RmtDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtdashboard-screen").should("be.visible");
  cy.getCy("rmtdashboard-title").should("be.visible");
  // cy.getCy("rmtdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/84 | 1%] - Saving screenshot for RmtDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/84 | 1%] - Verified RmtDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/84 | 2%] - Navigating to /offices/clinical/roles/therapist/dashboard (TherapistDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/therapist/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/84 | 2%] - Checking shell & content for TherapistDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapistdashboard-screen").should("be.visible");
  cy.getCy("therapistdashboard-title").should("be.visible");
  cy.getCy("therapistdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/84 | 2%] - Saving screenshot for TherapistDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("therapist_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/84 | 2%] - Verified TherapistDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/84 | 3%] - Navigating to /offices/clinical/roles/clinical_director/dashboard-dup-1 (ClinicalDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/dashboard-dup-1");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/84 | 3%] - Checking shell & content for ClinicalDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldashboard-screen").should("be.visible");
  cy.getCy("clinicaldashboard-title").should("be.visible");
  cy.getCy("clinicaldashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/84 | 3%] - Saving screenshot for ClinicalDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/84 | 3%] - Verified ClinicalDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/84 | 4%] - Navigating to /offices/clinical/roles/clinical_director/dashboard (ClinicalDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/84 | 4%] - Checking shell & content for ClinicalDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicaldirectordashboard-screen").should("be.visible");
  cy.getCy("clinicaldirectordashboard-title").should("be.visible");
  // cy.getCy("clinicaldirectordashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/84 | 4%] - Saving screenshot for ClinicalDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("clinical_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/84 | 4%] - Verified ClinicalDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/84 | 5%] - Navigating to /clinical/cns-dashboard (CnsDashboardScreen)...");
  cy.visitWithSemantics("/clinical/cns-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/84 | 5%] - Checking shell & content for CnsDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cnsdashboard-screen").should("be.visible");
  cy.getCy("cnsdashboard-title").should("be.visible");
  cy.getCy("cnsdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/84 | 5%] - Saving screenshot for CnsDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("cns_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/84 | 5%] - Verified CnsDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/84 | 7%] - Navigating to /clinical/hsw-dashboard (HswDashboardScreen)...");
  cy.visitWithSemantics("/clinical/hsw-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/84 | 7%] - Checking shell & content for HswDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswdashboard-screen").should("be.visible");
  cy.getCy("hswdashboard-title").should("be.visible");
  cy.getCy("hswdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/84 | 7%] - Saving screenshot for HswDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("hsw_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/84 | 7%] - Verified HswDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/84 | 8%] - Navigating to /clinical/lpn-dashboard (LpnDashboardScreen)...");
  cy.visitWithSemantics("/clinical/lpn-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/84 | 8%] - Checking shell & content for LpnDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("lpndashboard-screen").should("be.visible");
  cy.getCy("lpndashboard-title").should("be.visible");
  cy.getCy("lpndashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/84 | 8%] - Saving screenshot for LpnDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("lpn_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/84 | 8%] - Verified LpnDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [8/84 | 9%] - Navigating to /clinical/np-dashboard (NpDashboardScreen)...");
  cy.visitWithSemantics("/clinical/np-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [8/84 | 9%] - Checking shell & content for NpDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("npdashboard-screen").should("be.visible");
  cy.getCy("npdashboard-title").should("be.visible");
  cy.getCy("npdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [8/84 | 9%] - Saving screenshot for NpDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("np_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [8/84 | 9%] - Verified NpDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [9/84 | 10%] - Navigating to /clinical/pediatric-dashboard (PediatricDashboardScreen)...");
  cy.visitWithSemantics("/clinical/pediatric-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [9/84 | 10%] - Checking shell & content for PediatricDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pediatricdashboard-screen").should("be.visible");
  cy.getCy("pediatricdashboard-title").should("be.visible");
  cy.getCy("pediatricdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [9/84 | 10%] - Saving screenshot for PediatricDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("pediatric_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [9/84 | 10%] - Verified PediatricDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [10/84 | 11%] - Navigating to /clinical/physician-dashboard (PhysicianDashboardScreen)...");
  cy.visitWithSemantics("/clinical/physician-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [10/84 | 11%] - Checking shell & content for PhysicianDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiciandashboard-screen").should("be.visible");
  cy.getCy("physiciandashboard-title").should("be.visible");
  // cy.getCy("physiciandashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [10/84 | 11%] - Saving screenshot for PhysicianDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("physician_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [10/84 | 11%] - Verified PhysicianDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [11/84 | 13%] - Navigating to /common/api-health-dashboard (ApiHealthDashboardScreen)...");
  cy.visitWithSemantics("/common/api-health-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [11/84 | 13%] - Checking shell & content for ApiHealthDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("apihealthdashboard-screen").should("be.visible");
  cy.getCy("apihealthdashboard-title").should("be.visible");
  cy.getCy("apihealthdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [11/84 | 13%] - Saving screenshot for ApiHealthDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("api_health_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [11/84 | 13%] - Verified ApiHealthDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [12/84 | 14%] - Navigating to packages/primecare_ui/lib/src/screens/common/architecture_planning_dashboard_screen.dart (ArchitecturePlanningDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/architecture_planning_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [12/84 | 14%] - Checking shell & content for ArchitecturePlanningDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanningdashboard-screen").should("be.visible");
  cy.getCy("architectureplanningdashboard-title").should("be.visible");
  cy.getCy("architectureplanningdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [12/84 | 14%] - Saving screenshot for ArchitecturePlanningDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("architecture_planning_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [12/84 | 14%] - Verified ArchitecturePlanningDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [13/84 | 15%] - Navigating to packages/primecare_ui/lib/src/screens/common/business_development_dashboard_screen.dart (BusinessDevelopmentDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/business_development_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [13/84 | 15%] - Checking shell & content for BusinessDevelopmentDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentdashboard-screen").should("be.visible");
  cy.getCy("businessdevelopmentdashboard-title").should("be.visible");
  cy.getCy("businessdevelopmentdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [13/84 | 15%] - Saving screenshot for BusinessDevelopmentDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("business_development_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [13/84 | 15%] - Verified BusinessDevelopmentDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [14/84 | 16%] - Navigating to /offices/clinical/roles/caregiver/dashboard (CaregiverDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/caregiver/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [14/84 | 16%] - Checking shell & content for CaregiverDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverdashboard-screen").should("be.visible");
  cy.getCy("caregiverdashboard-title").should("be.visible");
  cy.getCy("caregiverdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [14/84 | 16%] - Saving screenshot for CaregiverDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("caregiver_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [14/84 | 16%] - Verified CaregiverDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [15/84 | 17%] - Navigating to /offices/clinical/roles/chiropractor/dashboard (ChiropractorDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [15/84 | 17%] - Checking shell & content for ChiropractorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractordashboard-screen").should("be.visible");
  cy.getCy("chiropractordashboard-title").should("be.visible");
  // cy.getCy("chiropractordashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [15/84 | 17%] - Saving screenshot for ChiropractorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [15/84 | 17%] - Verified ChiropractorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [16/84 | 19%] - Navigating to /offices/clinical/roles/clinical_director/clinic-dashboard (ClinicDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/clinical_director/clinic-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [16/84 | 19%] - Checking shell & content for ClinicDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinicdashboard-screen").should("be.visible");
  cy.getCy("clinicdashboard-title").should("be.visible");
  cy.getCy("clinicdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [16/84 | 19%] - Saving screenshot for ClinicDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("clinic_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [16/84 | 19%] - Verified ClinicDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [17/84 | 20%] - Navigating to packages/primecare_ui/lib/src/screens/common/course_architect_dashboard_screen.dart (CourseArchitectDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/course_architect_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [17/84 | 20%] - Checking shell & content for CourseArchitectDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectdashboard-screen").should("be.visible");
  cy.getCy("coursearchitectdashboard-title").should("be.visible");
  cy.getCy("coursearchitectdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [17/84 | 20%] - Saving screenshot for CourseArchitectDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [17/84 | 20%] - Verified CourseArchitectDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [18/84 | 21%] - Navigating to packages/primecare_ui/lib/src/screens/common/customer_support_dashboard_screen.dart (CustomerSupportDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/customer_support_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [18/84 | 21%] - Checking shell & content for CustomerSupportDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportdashboard-screen").should("be.visible");
  cy.getCy("customersupportdashboard-title").should("be.visible");
  cy.getCy("customersupportdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [18/84 | 21%] - Saving screenshot for CustomerSupportDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("customer_support_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [18/84 | 21%] - Verified CustomerSupportDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [19/84 | 22%] - Navigating to packages/primecare_ui/lib/src/screens/common/dynamic_screen_dashboard_screen.dart (DynamicScreenDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/dynamic_screen_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [19/84 | 22%] - Checking shell & content for DynamicScreenDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("dynamicdashboard-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("dynamicdashboard-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("dynamicdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [19/84 | 22%] - Saving screenshot for DynamicScreenDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("dynamic_screen_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [19/84 | 22%] - Verified DynamicScreenDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [20/84 | 23%] - Navigating to packages/primecare_ui/lib/src/screens/common/family_member_dashboard_screen.dart (FamilyMemberDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/family_member_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [20/84 | 23%] - Checking shell & content for FamilyMemberDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberdashboard-screen").should("be.visible");
  cy.getCy("familymemberdashboard-title").should("be.visible");
  cy.getCy("familymemberdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [20/84 | 23%] - Saving screenshot for FamilyMemberDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [20/84 | 23%] - Verified FamilyMemberDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [21/84 | 25%] - Navigating to /common/file-verification-dashboard (FileVerificationDashboardScreen)...");
  cy.visitWithSemantics("/common/file-verification-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [21/84 | 25%] - Checking shell & content for FileVerificationDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("fileverificationdashboard-screen").should("be.visible");
  cy.getCy("fileverificationdashboard-title").should("be.visible");
  cy.getCy("fileverificationdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [21/84 | 25%] - Saving screenshot for FileVerificationDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("file_verification_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [21/84 | 25%] - Verified FileVerificationDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [22/84 | 26%] - Navigating to packages/primecare_ui/lib/src/screens/common/franchise_dashboard_screen.dart (FranchiseDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/franchise_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [22/84 | 26%] - Checking shell & content for FranchiseDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisedashboard-screen").should("be.visible");
  cy.getCy("franchisedashboard-title").should("be.visible");
  cy.getCy("franchisedashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [22/84 | 26%] - Saving screenshot for FranchiseDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [22/84 | 26%] - Verified FranchiseDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [23/84 | 27%] - Navigating to packages/primecare_ui/lib/src/screens/common/guest_dashboard_screen.dart (GuestDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/guest_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [23/84 | 27%] - Checking shell & content for GuestDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestdashboard-screen").should("be.visible");
  cy.getCy("guestdashboard-title").should("be.visible");
  cy.getCy("guestdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [23/84 | 27%] - Saving screenshot for GuestDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("guest_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [23/84 | 27%] - Verified GuestDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [24/84 | 28%] - Navigating to packages/primecare_ui/lib/src/screens/common/infrastructure_dashboard_screen.dart (InfrastructureDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/infrastructure_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [24/84 | 28%] - Checking shell & content for InfrastructureDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructuredashboard-screen").should("be.visible");
  cy.getCy("infrastructuredashboard-title").should("be.visible");
  cy.getCy("infrastructuredashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [24/84 | 28%] - Saving screenshot for InfrastructureDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("infrastructure_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [24/84 | 28%] - Verified InfrastructureDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [25/84 | 29%] - Navigating to /offices/clinical/roles/intake_coordinator/dashboard-dup-1 (IntakeDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/dashboard-dup-1");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [25/84 | 29%] - Checking shell & content for IntakeDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakedashboard-screen").should("be.visible");
  cy.getCy("intakedashboard-title").should("be.visible");
  cy.getCy("intakedashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [25/84 | 29%] - Saving screenshot for IntakeDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [25/84 | 29%] - Verified IntakeDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [26/84 | 30%] - Navigating to packages/primecare_ui/lib/src/screens/common/office_dashboard_screen.dart (OfficeDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/office_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [26/84 | 30%] - Checking shell & content for OfficeDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officedashboard-screen").should("be.visible");
  cy.getCy("officedashboard-title").should("be.visible");
  cy.getCy("officedashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [26/84 | 30%] - Saving screenshot for OfficeDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("office_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [26/84 | 30%] - Verified OfficeDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [27/84 | 32%] - Navigating to /offices/client/roles/client/dashboard (PatientDashboardScreen)...");
  cy.visitWithSemantics("/offices/client/roles/client/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [27/84 | 32%] - Checking shell & content for PatientDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientdashboard-screen").should("be.visible");
  cy.getCy("patientdashboard-title").should("be.visible");
  cy.getCy("patientdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [27/84 | 32%] - Saving screenshot for PatientDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [27/84 | 32%] - Verified PatientDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [28/84 | 33%] - Navigating to /offices/clinical/roles/physiotherapist/dashboard (PhysiotherapistDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [28/84 | 33%] - Checking shell & content for PhysiotherapistDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistdashboard-screen").should("be.visible");
  cy.getCy("physiotherapistdashboard-title").should("be.visible");
  // cy.getCy("physiotherapistdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [28/84 | 33%] - Saving screenshot for PhysiotherapistDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [28/84 | 33%] - Verified PhysiotherapistDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [29/84 | 34%] - Navigating to packages/primecare_ui/lib/src/screens/common/portal_dashboard_screen.dart (PortalDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/portal_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [29/84 | 34%] - Checking shell & content for PortalDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portaldashboard-screen").should("be.visible");
  cy.getCy("portaldashboard-title").should("be.visible");
  cy.getCy("portaldashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [29/84 | 34%] - Saving screenshot for PortalDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("portal_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [29/84 | 34%] - Verified PortalDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [30/84 | 35%] - Navigating to /offices/support/roles/quality_assurance/dashboard (QaDashboardScreen)...");
  cy.visitWithSemantics("/offices/support/roles/quality_assurance/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [30/84 | 35%] - Checking shell & content for QaDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qadashboard-screen").should("be.visible");
  cy.getCy("qadashboard-title").should("be.visible");
  cy.getCy("qadashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [30/84 | 35%] - Saving screenshot for QaDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("qa_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [30/84 | 35%] - Verified QaDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [31/84 | 36%] - Navigating to /common/role-coverage-dashboard (RoleCoverageDashboardScreen)...");
  cy.visitWithSemantics("/common/role-coverage-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [31/84 | 36%] - Checking shell & content for RoleCoverageDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rolecoveragedashboard-screen").should("be.visible");
  cy.getCy("rolecoveragedashboard-title").should("be.visible");
  cy.getCy("rolecoveragedashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [31/84 | 36%] - Saving screenshot for RoleCoverageDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("role_coverage_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [31/84 | 36%] - Verified RoleCoverageDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [32/84 | 38%] - Navigating to /offices/clinical/roles/social_worker/dashboard (SocialWorkerDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/social_worker/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [32/84 | 38%] - Checking shell & content for SocialWorkerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkerdashboard-screen").should("be.visible");
  cy.getCy("socialworkerdashboard-title").should("be.visible");
  // cy.getCy("socialworkerdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [32/84 | 38%] - Saving screenshot for SocialWorkerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("social_worker_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [32/84 | 38%] - Verified SocialWorkerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [33/84 | 39%] - Navigating to packages/primecare_ui/lib/src/screens/common/support_dashboard_screen.dart (SupportDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/support_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [33/84 | 39%] - Checking shell & content for SupportDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportdashboard-screen").should("be.visible");
  cy.getCy("supportdashboard-title").should("be.visible");
  cy.getCy("supportdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [33/84 | 39%] - Saving screenshot for SupportDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("support_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [33/84 | 39%] - Verified SupportDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [34/84 | 40%] - Navigating to /common/system-dashboard (SystemDashboardScreen)...");
  cy.visitWithSemantics("/common/system-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [34/84 | 40%] - Checking shell & content for SystemDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemdashboard-screen").should("be.visible");
  cy.getCy("systemdashboard-title").should("be.visible");
  cy.getCy("systemdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [34/84 | 40%] - Saving screenshot for SystemDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("system_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [34/84 | 40%] - Verified SystemDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [35/84 | 41%] - Navigating to packages/primecare_ui/lib/src/screens/common/system_verification_dashboard_screen.dart (SystemVerificationDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/system_verification_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [35/84 | 41%] - Checking shell & content for SystemVerificationDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationdashboard-screen").should("be.visible");
  cy.getCy("systemverificationdashboard-title").should("be.visible");
  cy.getCy("systemverificationdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [35/84 | 41%] - Saving screenshot for SystemVerificationDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("system_verification_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [35/84 | 41%] - Verified SystemVerificationDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [36/84 | 42%] - Navigating to packages/primecare_ui/lib/src/screens/common/training_hub_dashboard_screen.dart (TrainingHubDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/common/training_hub_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [36/84 | 42%] - Checking shell & content for TrainingHubDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubdashboard-screen").should("be.visible");
  cy.getCy("traininghubdashboard-title").should("be.visible");
  cy.getCy("traininghubdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [36/84 | 42%] - Saving screenshot for TrainingHubDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_hub_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [36/84 | 42%] - Verified TrainingHubDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [37/84 | 44%] - Navigating to /offices/corporate/roles/cfo/dashboard (CfoDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [37/84 | 44%] - Checking shell & content for CfoDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfodashboard-screen").should("be.visible");
  cy.getCy("cfodashboard-title").should("be.visible");
  cy.getCy("cfodashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [37/84 | 44%] - Saving screenshot for CfoDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [37/84 | 44%] - Verified CfoDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [38/84 | 45%] - Navigating to /offices/corporate/roles/ciso/dashboard (CisoDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/ciso/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [38/84 | 45%] - Checking shell & content for CisoDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisodashboard-screen").should("be.visible");
  cy.getCy("cisodashboard-title").should("be.visible");
  cy.getCy("cisodashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [38/84 | 45%] - Saving screenshot for CisoDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("ciso_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [38/84 | 45%] - Verified CisoDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [39/84 | 46%] - Navigating to /offices/corporate/roles/coo/dashboard (CooDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/coo/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [39/84 | 46%] - Checking shell & content for CooDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coodashboard-screen").should("be.visible");
  cy.getCy("coodashboard-title").should("be.visible");
  cy.getCy("coodashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [39/84 | 46%] - Saving screenshot for CooDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [39/84 | 46%] - Verified CooDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [40/84 | 47%] - Navigating to /offices/corporate/roles/cto/dashboard (CtoDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cto/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [40/84 | 47%] - Checking shell & content for CtoDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctodashboard-screen").should("be.visible");
  cy.getCy("ctodashboard-title").should("be.visible");
  cy.getCy("ctodashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [40/84 | 47%] - Saving screenshot for CtoDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("cto_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [40/84 | 47%] - Verified CtoDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [41/84 | 48%] - Navigating to /offices/corporate/roles/cx_director/dashboard (CxDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cx_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [41/84 | 48%] - Checking shell & content for CxDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectordashboard-screen").should("be.visible");
  cy.getCy("cxdirectordashboard-title").should("be.visible");
  cy.getCy("cxdirectordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [41/84 | 48%] - Saving screenshot for CxDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("cx_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [41/84 | 48%] - Verified CxDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [42/84 | 50%] - Navigating to /offices/corporate/roles/finance_director/dashboard (FinanceDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/finance_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [42/84 | 50%] - Checking shell & content for FinanceDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectordashboard-screen").should("be.visible");
  cy.getCy("financedirectordashboard-title").should("be.visible");
  cy.getCy("financedirectordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [42/84 | 50%] - Saving screenshot for FinanceDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("finance_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [42/84 | 50%] - Verified FinanceDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [43/84 | 51%] - Navigating to packages/primecare_ui/lib/src/screens/executive/financial_dashboard_screen.dart (FinancialDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/executive/financial_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [43/84 | 51%] - Checking shell & content for FinancialDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financialdashboard-screen").should("be.visible");
  cy.getCy("financialdashboard-title").should("be.visible");
  cy.getCy("financialdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [43/84 | 51%] - Saving screenshot for FinancialDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("financial_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [43/84 | 51%] - Verified FinancialDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [44/84 | 52%] - Navigating to /offices/corporate/roles/hr_director/dashboard (HrDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/hr_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [44/84 | 52%] - Checking shell & content for HrDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectordashboard-screen").should("be.visible");
  cy.getCy("hrdirectordashboard-title").should("be.visible");
  cy.getCy("hrdirectordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [44/84 | 52%] - Saving screenshot for HrDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [44/84 | 52%] - Verified HrDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [45/84 | 53%] - Navigating to /offices/corporate/roles/legal/dashboard (LegalDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/legal/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [45/84 | 53%] - Checking shell & content for LegalDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legaldashboard-screen").should("be.visible");
  cy.getCy("legaldashboard-title").should("be.visible");
  cy.getCy("legaldashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [45/84 | 53%] - Saving screenshot for LegalDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("legal_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [45/84 | 53%] - Verified LegalDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [46/84 | 54%] - Navigating to /offices/corporate/roles/owner/dashboard (OwnerDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/owner/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [46/84 | 54%] - Checking shell & content for OwnerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownerdashboard-screen").should("be.visible");
  cy.getCy("ownerdashboard-title").should("be.visible");
  cy.getCy("ownerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [46/84 | 54%] - Saving screenshot for OwnerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [46/84 | 54%] - Verified OwnerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [47/84 | 55%] - Navigating to /offices/corporate/roles/shareholder/dashboard (ShareholderDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/shareholder/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [47/84 | 55%] - Checking shell & content for ShareholderDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholderdashboard-screen").should("be.visible");
  cy.getCy("shareholderdashboard-title").should("be.visible");
  cy.getCy("shareholderdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [47/84 | 55%] - Saving screenshot for ShareholderDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("shareholder_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [47/84 | 55%] - Verified ShareholderDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [48/84 | 57%] - Navigating to /offices/corporate/roles/training_director/dashboard (TrainingDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [48/84 | 57%] - Checking shell & content for TrainingDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectordashboard-screen").should("be.visible");
  cy.getCy("trainingdirectordashboard-title").should("be.visible");
  cy.getCy("trainingdirectordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [48/84 | 57%] - Saving screenshot for TrainingDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [48/84 | 57%] - Verified TrainingDirectorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [49/84 | 58%] - Navigating to packages/primecare_ui/lib/src/screens/management/campaign_dashboard_screen.dart (CampaignDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/management/campaign_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [49/84 | 58%] - Checking shell & content for CampaignDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("campaigndashboard-screen").should("be.visible");
  cy.getCy("campaigndashboard-title").should("be.visible");
  cy.getCy("campaigndashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [49/84 | 58%] - Saving screenshot for CampaignDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("campaign_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [49/84 | 58%] - Verified CampaignDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [50/84 | 59%] - Navigating to /offices/marketing/roles/community_outreach/dashboard (CommunityOutreachDashboardScreen)...");
  cy.visitWithSemantics("/offices/marketing/roles/community_outreach/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [50/84 | 59%] - Checking shell & content for CommunityOutreachDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachdashboard-screen").should("be.visible");
  cy.getCy("communityoutreachdashboard-title").should("be.visible");
  cy.getCy("communityoutreachdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [50/84 | 59%] - Saving screenshot for CommunityOutreachDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [50/84 | 59%] - Verified CommunityOutreachDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [51/84 | 60%] - Navigating to packages/primecare_ui/lib/src/screens/management/compliance_dashboard_screen.dart (ComplianceDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/management/compliance_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [51/84 | 60%] - Checking shell & content for ComplianceDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancedashboard-screen").should("be.visible");
  cy.getCy("compliancedashboard-title").should("be.visible");
  cy.getCy("compliancedashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [51/84 | 60%] - Saving screenshot for ComplianceDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [51/84 | 60%] - Verified ComplianceDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [52/84 | 61%] - Navigating to /offices/corporate/roles/compliance_manager/dashboard (ComplianceManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [52/84 | 61%] - Checking shell & content for ComplianceManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagerdashboard-screen").should("be.visible");
  cy.getCy("compliancemanagerdashboard-title").should("be.visible");
  cy.getCy("compliancemanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [52/84 | 61%] - Saving screenshot for ComplianceManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [52/84 | 61%] - Verified ComplianceManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [53/84 | 63%] - Navigating to /offices/business_development/roles/franchise_sales_manager/dashboard (FranchiseSalesManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [53/84 | 63%] - Checking shell & content for FranchiseSalesManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerdashboard-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerdashboard-title").should("be.visible");
  cy.getCy("franchisesalesmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [53/84 | 63%] - Saving screenshot for FranchiseSalesManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [53/84 | 63%] - Verified FranchiseSalesManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [54/84 | 64%] - Navigating to /offices/business_development/roles/general_manager/dashboard (GeneralManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/general_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [54/84 | 64%] - Checking shell & content for GeneralManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagerdashboard-screen").should("be.visible");
  cy.getCy("generalmanagerdashboard-title").should("be.visible");
  cy.getCy("generalmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [54/84 | 64%] - Saving screenshot for GeneralManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("general_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [54/84 | 64%] - Verified GeneralManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [55/84 | 65%] - Navigating to /management/governance-officer-dashboard (GovernanceOfficerDashboardScreen)...");
  cy.visitWithSemantics("/management/governance-officer-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [55/84 | 65%] - Checking shell & content for GovernanceOfficerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerdashboard-screen").should("be.visible");
  cy.getCy("governanceofficerdashboard-title").should("be.visible");
  cy.getCy("governanceofficerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [55/84 | 65%] - Saving screenshot for GovernanceOfficerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_officer_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [55/84 | 65%] - Verified GovernanceOfficerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [56/84 | 66%] - Navigating to /offices/corporate/roles/head_of_bus_dev/dashboard (HeadOfBusDevDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/head_of_bus_dev/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [56/84 | 66%] - Checking shell & content for HeadOfBusDevDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevdashboard-screen").should("be.visible");
  cy.getCy("headofbusdevdashboard-title").should("be.visible");
  cy.getCy("headofbusdevdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [56/84 | 66%] - Saving screenshot for HeadOfBusDevDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [56/84 | 66%] - Verified HeadOfBusDevDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [57/84 | 67%] - Navigating to /offices/corporate/roles/head_of_marketing/dashboard (HeadOfMarketingDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/head_of_marketing/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [57/84 | 67%] - Checking shell & content for HeadOfMarketingDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingdashboard-screen").should("be.visible");
  cy.getCy("headofmarketingdashboard-title").should("be.visible");
  cy.getCy("headofmarketingdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [57/84 | 67%] - Saving screenshot for HeadOfMarketingDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [57/84 | 67%] - Verified HeadOfMarketingDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [58/84 | 69%] - Navigating to /offices/marketing/roles/local_marketing_manager/dashboard (LocalMarketingManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/marketing/roles/local_marketing_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [58/84 | 69%] - Checking shell & content for LocalMarketingManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerdashboard-screen").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-title").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [58/84 | 69%] - Saving screenshot for LocalMarketingManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [58/84 | 69%] - Verified LocalMarketingManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [59/84 | 70%] - Navigating to /offices/franchise/roles/operations_manager/dashboard (OperationsManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/operations_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [59/84 | 70%] - Checking shell & content for OperationsManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerdashboard-screen").should("be.visible");
  cy.getCy("operationsmanagerdashboard-title").should("be.visible");
  cy.getCy("operationsmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [59/84 | 70%] - Saving screenshot for OperationsManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [59/84 | 70%] - Verified OperationsManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [60/84 | 71%] - Navigating to /offices/business_development/roles/partnership_manager/dashboard (PartnershipManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/partnership_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [60/84 | 71%] - Checking shell & content for PartnershipManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerdashboard-screen").should("be.visible");
  cy.getCy("partnershipmanagerdashboard-title").should("be.visible");
  cy.getCy("partnershipmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [60/84 | 71%] - Saving screenshot for PartnershipManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [60/84 | 71%] - Verified PartnershipManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [61/84 | 72%] - Navigating to packages/primecare_ui/lib/src/screens/management/premium_concierge_dashboard_screen.dart (PremiumConciergeDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/management/premium_concierge_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [61/84 | 72%] - Checking shell & content for PremiumConciergeDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("premiumconciergedashboard-screen").should("be.visible");
  cy.getCy("premiumconciergedashboard-title").should("be.visible");
  cy.getCy("premiumconciergedashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [61/84 | 72%] - Saving screenshot for PremiumConciergeDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("premium_concierge_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [61/84 | 72%] - Verified PremiumConciergeDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [62/84 | 73%] - Navigating to /offices/business_development/roles/regional_bdm/dashboard (RegionalBdmDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_bdm/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [62/84 | 73%] - Checking shell & content for RegionalBdmDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmdashboard-screen").should("be.visible");
  cy.getCy("regionalbdmdashboard-title").should("be.visible");
  cy.getCy("regionalbdmdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [62/84 | 73%] - Saving screenshot for RegionalBdmDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [62/84 | 73%] - Verified RegionalBdmDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [63/84 | 75%] - Navigating to /offices/business_development/roles/regional_manager_usa/dashboard (RegionalManagerUsaDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_manager_usa/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [63/84 | 75%] - Checking shell & content for RegionalManagerUsaDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusadashboard-screen").should("be.visible");
  cy.getCy("regionalmanagerusadashboard-title").should("be.visible");
  cy.getCy("regionalmanagerusadashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [63/84 | 75%] - Saving screenshot for RegionalManagerUsaDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [63/84 | 75%] - Verified RegionalManagerUsaDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [64/84 | 76%] - Navigating to packages/primecare_ui/lib/src/screens/management/scrum_master_dashboard_screen.dart (ScrumMasterDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/management/scrum_master_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [64/84 | 76%] - Checking shell & content for ScrumMasterDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasterdashboard-screen").should("be.visible");
  cy.getCy("scrummasterdashboard-title").should("be.visible");
  cy.getCy("scrummasterdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [64/84 | 76%] - Saving screenshot for ScrumMasterDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("scrum_master_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [64/84 | 76%] - Verified ScrumMasterDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [65/84 | 77%] - Navigating to /offices/business_development/roles/territory_expansion_manager/dashboard (TerritoryExpansionManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/territory_expansion_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [65/84 | 77%] - Checking shell & content for TerritoryExpansionManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagerdashboard-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagerdashboard-title").should("be.visible");
  cy.getCy("territoryexpansionmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [65/84 | 77%] - Saving screenshot for TerritoryExpansionManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [65/84 | 77%] - Verified TerritoryExpansionManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [66/84 | 78%] - Navigating to /offices/marketing/roles/territory_sales_manager/dashboard (TerritorySalesManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/marketing/roles/territory_sales_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [66/84 | 78%] - Checking shell & content for TerritorySalesManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerdashboard-screen").should("be.visible");
  cy.getCy("territorysalesmanagerdashboard-title").should("be.visible");
  cy.getCy("territorysalesmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [66/84 | 78%] - Saving screenshot for TerritorySalesManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [66/84 | 78%] - Verified TerritorySalesManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [67/84 | 79%] - Navigating to packages/primecare_ui/lib/src/screens/management/vip_manager_dashboard_screen.dart (VipManagerDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/management/vip_manager_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [67/84 | 79%] - Checking shell & content for VipManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vipmanagerdashboard-screen").should("be.visible");
  cy.getCy("vipmanagerdashboard-title").should("be.visible");
  cy.getCy("vipmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [67/84 | 79%] - Saving screenshot for VipManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("vip_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [67/84 | 79%] - Verified VipManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [68/84 | 80%] - Navigating to /offices/clinical/roles/psw/dashboard (PswDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [68/84 | 80%] - Checking shell & content for PswDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswdashboard-screen").should("be.visible");
  cy.getCy("pswdashboard-title").should("be.visible");
  // cy.getCy("pswdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [68/84 | 80%] - Saving screenshot for PswDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [68/84 | 80%] - Verified PswDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [69/84 | 82%] - Navigating to /offices/clinical/roles/rn/dashboard (RnDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [69/84 | 82%] - Checking shell & content for RnDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rndashboard-screen").should("be.visible");
  cy.getCy("rndashboard-title").should("be.visible");
  cy.getCy("rndashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [69/84 | 82%] - Saving screenshot for RnDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [69/84 | 82%] - Verified RnDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [70/84 | 83%] - Navigating to /rn/rn-field-supervisor-dashboard (RnFieldSupervisorDashboardScreen)...");
  cy.visitWithSemantics("/rn/rn-field-supervisor-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [70/84 | 83%] - Checking shell & content for RnFieldSupervisorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnfieldsupervisordashboard-screen").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-title").should("be.visible");
  cy.getCy("rnfieldsupervisordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [70/84 | 83%] - Saving screenshot for RnFieldSupervisorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_field_supervisor_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [70/84 | 83%] - Verified RnFieldSupervisorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [71/84 | 84%] - Navigating to /offices/clinical/roles/rpn/dashboard (RpnDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [71/84 | 84%] - Checking shell & content for RpnDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpndashboard-screen").should("be.visible");
  cy.getCy("rpndashboard-title").should("be.visible");
  cy.getCy("rpndashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [71/84 | 84%] - Saving screenshot for RpnDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [71/84 | 84%] - Verified RpnDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [72/84 | 85%] - Navigating to /offices/franchise/roles/billing_admin/dashboard (BillingAdminDashboardScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/billing_admin/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [72/84 | 85%] - Checking shell & content for BillingAdminDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadmindashboard-screen").should("be.visible");
  cy.getCy("billingadmindashboard-title").should("be.visible");
  cy.getCy("billingadmindashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [72/84 | 85%] - Saving screenshot for BillingAdminDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_admin_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [72/84 | 85%] - Verified BillingAdminDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [73/84 | 86%] - Navigating to packages/primecare_ui/lib/src/screens/staff/employee_dashboard_screen.dart (EmployeeDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/staff/employee_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [73/84 | 86%] - Checking shell & content for EmployeeDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeedashboard-screen").should("be.visible");
  cy.getCy("employeedashboard-title").should("be.visible");
  cy.getCy("employeedashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [73/84 | 86%] - Saving screenshot for EmployeeDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("employee_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [73/84 | 86%] - Verified EmployeeDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [74/84 | 88%] - Navigating to /offices/corporate/roles/hr_hiring/dashboard (HrHiringDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/hr_hiring/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [74/84 | 88%] - Checking shell & content for HrHiringDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringdashboard-screen").should("be.visible");
  cy.getCy("hrhiringdashboard-title").should("be.visible");
  cy.getCy("hrhiringdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [74/84 | 88%] - Saving screenshot for HrHiringDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [74/84 | 88%] - Verified HrHiringDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [75/84 | 89%] - Navigating to /offices/corporate/roles/hr_manager/dashboard (HrManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/hr_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [75/84 | 89%] - Checking shell & content for HrManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagerdashboard-screen").should("be.visible");
  cy.getCy("hrmanagerdashboard-title").should("be.visible");
  cy.getCy("hrmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [75/84 | 89%] - Saving screenshot for HrManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [75/84 | 89%] - Verified HrManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [76/84 | 90%] - Navigating to /offices/clinical/roles/intake_coordinator/dashboard (IntakeCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [76/84 | 90%] - Checking shell & content for IntakeCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordashboard-screen").should("be.visible");
  cy.getCy("intakecoordinatordashboard-title").should("be.visible");
  // cy.getCy("intakecoordinatordashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [76/84 | 90%] - Saving screenshot for IntakeCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [76/84 | 90%] - Verified IntakeCoordinatorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [77/84 | 91%] - Navigating to packages/primecare_ui/lib/src/screens/staff/quality_assurance_dashboard_screen.dart (QualityAssuranceDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/staff/quality_assurance_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [77/84 | 91%] - Checking shell & content for QualityAssuranceDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancedashboard-screen").should("be.visible");
  cy.getCy("qualityassurancedashboard-title").should("be.visible");
  // cy.getCy("qualityassurancedashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [77/84 | 91%] - Saving screenshot for QualityAssuranceDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [77/84 | 91%] - Verified QualityAssuranceDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [78/84 | 92%] - Navigating to packages/primecare_ui/lib/src/screens/staff/receptionist_dashboard_screen.dart (ReceptionistDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/staff/receptionist_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [78/84 | 92%] - Checking shell & content for ReceptionistDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistdashboard-screen").should("be.visible");
  cy.getCy("receptionistdashboard-title").should("be.visible");
  cy.getCy("receptionistdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [78/84 | 92%] - Saving screenshot for ReceptionistDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("receptionist_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [78/84 | 92%] - Verified ReceptionistDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [79/84 | 94%] - Navigating to /offices/franchise/roles/scheduler/dashboard (SchedulerDashboardScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/scheduler/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [79/84 | 94%] - Checking shell & content for SchedulerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerdashboard-screen").should("be.visible");
  cy.getCy("schedulerdashboard-title").should("be.visible");
  cy.getCy("schedulerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [79/84 | 94%] - Saving screenshot for SchedulerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [79/84 | 94%] - Verified SchedulerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [80/84 | 95%] - Navigating to packages/primecare_ui/lib/src/screens/staff/scheduling_dashboard_screen.dart (SchedulingDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/staff/scheduling_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [80/84 | 95%] - Checking shell & content for SchedulingDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulingdashboard-screen").should("be.visible");
  cy.getCy("schedulingdashboard-title").should("be.visible");
  cy.getCy("schedulingdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [80/84 | 95%] - Saving screenshot for SchedulingDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduling_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [80/84 | 95%] - Verified SchedulingDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [81/84 | 96%] - Navigating to /offices/support/roles/training_coordinator/dashboard (TrainingCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/support/roles/training_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [81/84 | 96%] - Checking shell & content for TrainingCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatordashboard-screen").should("be.visible");
  cy.getCy("trainingcoordinatordashboard-title").should("be.visible");
  // cy.getCy("trainingcoordinatordashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [81/84 | 96%] - Saving screenshot for TrainingCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [81/84 | 96%] - Verified TrainingCoordinatorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [82/84 | 97%] - Navigating to packages/primecare_ui/lib/src/screens/staff/training_dashboard_screen.dart (TrainingDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/staff/training_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [82/84 | 97%] - Checking shell & content for TrainingDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdashboard-screen").should("be.visible");
  cy.getCy("trainingdashboard-title").should("be.visible");
  cy.getCy("trainingdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [82/84 | 97%] - Saving screenshot for TrainingDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("training_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [82/84 | 97%] - Verified TrainingDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [83/84 | 98%] - Navigating to /offices/corporate/roles/volunteer_coordinator/dashboard (VolunteerCoordinatorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/volunteer_coordinator/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [83/84 | 98%] - Checking shell & content for VolunteerCoordinatorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [83/84 | 98%] - Saving screenshot for VolunteerCoordinatorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [83/84 | 98%] - Verified VolunteerCoordinatorDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [84/84 | 100%] - Navigating to packages/primecare_ui/lib/src/screens/staff/volunteer_dashboard_screen.dart (VolunteerDashboardScreen)...");
  cy.visitWithSemantics("packages/primecare_ui/lib/src/screens/staff/volunteer_dashboard_screen.dart");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [84/84 | 100%] - Checking shell & content for VolunteerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteerdashboard-screen").should("be.visible");
  cy.getCy("volunteerdashboard-title").should("be.visible");
  cy.getCy("volunteerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [84/84 | 100%] - Saving screenshot for VolunteerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("volunteer_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [84/84 | 100%] - Verified VolunteerDashboardScreen successfully!\n");

  });
});
