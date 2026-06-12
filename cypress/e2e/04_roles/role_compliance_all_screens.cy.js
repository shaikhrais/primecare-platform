// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - compliance", () => {
  it("tests all screens for role compliance", () => {
    cy.loginAsRole("compliance");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/74 | 1%] - Navigating to /offices/corporate/roles/compliance_manager/dashboard (ComplianceManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/74 | 1%] - Checking shell & content for ComplianceManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagerdashboard-screen").should("be.visible");
  cy.getCy("compliancemanagerdashboard-title").should("be.visible");
  cy.getCy("compliancemanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/74 | 1%] - Saving screenshot for ComplianceManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/74 | 1%] - Verified ComplianceManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/74 | 2%] - Navigating to /offices/clinical/roles/rmt/compliance (RmtComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/74 | 2%] - Checking shell & content for RmtComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtcompliance-screen").should("be.visible");
  cy.getCy("rmtcompliance-title").should("be.visible");
  cy.getCy("rmtcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/74 | 2%] - Saving screenshot for RmtComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_compliance");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/74 | 2%] - Verified RmtComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/74 | 4%] - Navigating to /common/architecture-planning-compliance (ArchitecturePlanningComplianceScreen)...");
  cy.visitWithSemantics("/common/architecture-planning-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/74 | 4%] - Checking shell & content for ArchitecturePlanningComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanningcompliance-screen").should("be.visible");
  cy.getCy("architectureplanningcompliance-title").should("be.visible");
  cy.getCy("architectureplanningcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/74 | 4%] - Saving screenshot for ArchitecturePlanningComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("architecture_planning_compliance");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/74 | 4%] - Verified ArchitecturePlanningComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/74 | 5%] - Navigating to /common/business-development-compliance (BusinessDevelopmentComplianceScreen)...");
  cy.visitWithSemantics("/common/business-development-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/74 | 5%] - Checking shell & content for BusinessDevelopmentComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentcompliance-screen").should("be.visible");
  cy.getCy("businessdevelopmentcompliance-title").should("be.visible");
  cy.getCy("businessdevelopmentcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/74 | 5%] - Saving screenshot for BusinessDevelopmentComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("business_development_compliance");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [4/74 | 5%] - Verified BusinessDevelopmentComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/74 | 6%] - Navigating to /common/course-architect-compliance (CourseArchitectComplianceScreen)...");
  cy.visitWithSemantics("/common/course-architect-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/74 | 6%] - Checking shell & content for CourseArchitectComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectcompliance-screen").should("be.visible");
  cy.getCy("coursearchitectcompliance-title").should("be.visible");
  cy.getCy("coursearchitectcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/74 | 6%] - Saving screenshot for CourseArchitectComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_compliance");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [5/74 | 6%] - Verified CourseArchitectComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/74 | 8%] - Navigating to /common/dynamic-compliance (DynamicScreenComplianceScreen)...");
  cy.visitWithSemantics("/common/dynamic-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/74 | 8%] - Checking shell & content for DynamicScreenComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamiccompliance-screen").should("be.visible");
  cy.getCy("dynamiccompliance-title").should("be.visible");
  cy.getCy("dynamiccompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/74 | 8%] - Saving screenshot for DynamicScreenComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("dynamic_compliance");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [6/74 | 8%] - Verified DynamicScreenComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/74 | 9%] - Navigating to /common/family-member-compliance (FamilyMemberComplianceScreen)...");
  cy.visitWithSemantics("/common/family-member-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/74 | 9%] - Checking shell & content for FamilyMemberComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymembercompliance-screen").should("be.visible");
  cy.getCy("familymembercompliance-title").should("be.visible");
  cy.getCy("familymembercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/74 | 9%] - Saving screenshot for FamilyMemberComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_compliance");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [7/74 | 9%] - Verified FamilyMemberComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [8/74 | 10%] - Navigating to /common/franchise-compliance (FranchiseComplianceScreen)...");
  cy.visitWithSemantics("/common/franchise-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [8/74 | 10%] - Checking shell & content for FranchiseComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecompliance-screen").should("be.visible");
  cy.getCy("franchisecompliance-title").should("be.visible");
  cy.getCy("franchisecompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [8/74 | 10%] - Saving screenshot for FranchiseComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [8/74 | 10%] - Verified FranchiseComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [9/74 | 12%] - Navigating to /common/guest-compliance (GuestComplianceScreen)...");
  cy.visitWithSemantics("/common/guest-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [9/74 | 12%] - Checking shell & content for GuestComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestcompliance-screen").should("be.visible");
  cy.getCy("guestcompliance-title").should("be.visible");
  cy.getCy("guestcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [9/74 | 12%] - Saving screenshot for GuestComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("guest_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [9/74 | 12%] - Verified GuestComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [10/74 | 13%] - Navigating to /offices/clinical/roles/intake_coordinator/compliance (IntakeComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [10/74 | 13%] - Checking shell & content for IntakeComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecompliance-screen").should("be.visible");
  cy.getCy("intakecompliance-title").should("be.visible");
  cy.getCy("intakecompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [10/74 | 13%] - Saving screenshot for IntakeComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [10/74 | 13%] - Verified IntakeComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [11/74 | 14%] - Navigating to /common/office-compliance (OfficeComplianceScreen)...");
  cy.visitWithSemantics("/common/office-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [11/74 | 14%] - Checking shell & content for OfficeComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officecompliance-screen").should("be.visible");
  cy.getCy("officecompliance-title").should("be.visible");
  cy.getCy("officecompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [11/74 | 14%] - Saving screenshot for OfficeComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("office_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [11/74 | 14%] - Verified OfficeComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [12/74 | 16%] - Navigating to /common/patient-compliance (PatientComplianceScreen)...");
  cy.visitWithSemantics("/common/patient-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [12/74 | 16%] - Checking shell & content for PatientComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcompliance-screen").should("be.visible");
  cy.getCy("patientcompliance-title").should("be.visible");
  cy.getCy("patientcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [12/74 | 16%] - Saving screenshot for PatientComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [12/74 | 16%] - Verified PatientComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [13/74 | 17%] - Navigating to /offices/clinical/roles/physiotherapist/compliance (PhysiotherapistComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [13/74 | 17%] - Checking shell & content for PhysiotherapistComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistcompliance-screen").should("be.visible");
  cy.getCy("physiotherapistcompliance-title").should("be.visible");
  cy.getCy("physiotherapistcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [13/74 | 17%] - Saving screenshot for PhysiotherapistComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [13/74 | 17%] - Verified PhysiotherapistComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [14/74 | 18%] - Navigating to /common/portal-compliance (PortalComplianceScreen)...");
  cy.visitWithSemantics("/common/portal-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [14/74 | 18%] - Checking shell & content for PortalComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portalcompliance-screen").should("be.visible");
  cy.getCy("portalcompliance-title").should("be.visible");
  cy.getCy("portalcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [14/74 | 18%] - Saving screenshot for PortalComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("portal_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [14/74 | 18%] - Verified PortalComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [15/74 | 20%] - Navigating to /common/qa-compliance (QaComplianceScreen)...");
  cy.visitWithSemantics("/common/qa-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [15/74 | 20%] - Checking shell & content for QaComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qacompliance-screen").should("be.visible");
  cy.getCy("qacompliance-title").should("be.visible");
  cy.getCy("qacompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [15/74 | 20%] - Saving screenshot for QaComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("qa_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [15/74 | 20%] - Verified QaComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [16/74 | 21%] - Navigating to /common/support-compliance (SupportComplianceScreen)...");
  cy.visitWithSemantics("/common/support-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [16/74 | 21%] - Checking shell & content for SupportComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportcompliance-screen").should("be.visible");
  cy.getCy("supportcompliance-title").should("be.visible");
  cy.getCy("supportcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [16/74 | 21%] - Saving screenshot for SupportComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("support_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [16/74 | 21%] - Verified SupportComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [17/74 | 22%] - Navigating to /common/system-compliance (SystemComplianceScreen)...");
  cy.visitWithSemantics("/common/system-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [17/74 | 22%] - Checking shell & content for SystemComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemcompliance-screen").should("be.visible");
  cy.getCy("systemcompliance-title").should("be.visible");
  cy.getCy("systemcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [17/74 | 22%] - Saving screenshot for SystemComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("system_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [17/74 | 22%] - Verified SystemComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [18/74 | 24%] - Navigating to /common/training-hub-compliance (TrainingHubComplianceScreen)...");
  cy.visitWithSemantics("/common/training-hub-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [18/74 | 24%] - Checking shell & content for TrainingHubComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubcompliance-screen").should("be.visible");
  cy.getCy("traininghubcompliance-title").should("be.visible");
  cy.getCy("traininghubcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [18/74 | 24%] - Saving screenshot for TrainingHubComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("training_hub_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [18/74 | 24%] - Verified TrainingHubComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [19/74 | 25%] - Navigating to /executive/cfo-compliance (CfoComplianceScreen)...");
  cy.visitWithSemantics("/executive/cfo-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [19/74 | 25%] - Checking shell & content for CfoComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfocompliance-screen").should("be.visible");
  cy.getCy("cfocompliance-title").should("be.visible");
  cy.getCy("cfocompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [19/74 | 25%] - Saving screenshot for CfoComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [19/74 | 25%] - Verified CfoComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [20/74 | 27%] - Navigating to /executive/ciso-compliance (CisoComplianceScreen)...");
  cy.visitWithSemantics("/executive/ciso-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [20/74 | 27%] - Checking shell & content for CisoComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisocompliance-screen").should("be.visible");
  cy.getCy("cisocompliance-title").should("be.visible");
  cy.getCy("cisocompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [20/74 | 27%] - Saving screenshot for CisoComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("ciso_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [20/74 | 27%] - Verified CisoComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [21/74 | 28%] - Navigating to /offices/corporate/roles/coo/compliance-view (CooComplianceScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/coo/compliance-view");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [21/74 | 28%] - Checking shell & content for CooComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coocompliance-screen").should("be.visible");
  cy.getCy("coocompliance-title").should("be.visible");
  cy.getCy("coocompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [21/74 | 28%] - Saving screenshot for CooComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [21/74 | 28%] - Verified CooComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [22/74 | 29%] - Navigating to /executive/cto-compliance (CtoComplianceScreen)...");
  cy.visitWithSemantics("/executive/cto-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [22/74 | 29%] - Checking shell & content for CtoComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctocompliance-screen").should("be.visible");
  cy.getCy("ctocompliance-title").should("be.visible");
  cy.getCy("ctocompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [22/74 | 29%] - Saving screenshot for CtoComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("cto_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [22/74 | 29%] - Verified CtoComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [23/74 | 31%] - Navigating to /executive/legal-compliance (LegalComplianceScreen)...");
  cy.visitWithSemantics("/executive/legal-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [23/74 | 31%] - Checking shell & content for LegalComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legalcompliance-screen").should("be.visible");
  cy.getCy("legalcompliance-title").should("be.visible");
  cy.getCy("legalcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [23/74 | 31%] - Saving screenshot for LegalComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("legal_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [23/74 | 31%] - Verified LegalComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [24/74 | 32%] - Navigating to /executive/owner-compliance (OwnerComplianceScreen)...");
  cy.visitWithSemantics("/executive/owner-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [24/74 | 32%] - Checking shell & content for OwnerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownercompliance-screen").should("be.visible");
  cy.getCy("ownercompliance-title").should("be.visible");
  cy.getCy("ownercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [24/74 | 32%] - Saving screenshot for OwnerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("owner_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [24/74 | 32%] - Verified OwnerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [25/74 | 33%] - Navigating to /management/compliance-manager-analytics (ComplianceManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/compliance-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [25/74 | 33%] - Checking shell & content for ComplianceManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanageranalytics-screen").should("be.visible");
  cy.getCy("compliancemanageranalytics-title").should("be.visible");
  cy.getCy("compliancemanageranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [25/74 | 33%] - Saving screenshot for ComplianceManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [25/74 | 33%] - Verified ComplianceManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [26/74 | 35%] - Navigating to /management/compliance-manager-compliance (ComplianceManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/compliance-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [26/74 | 35%] - Checking shell & content for ComplianceManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagercompliance-screen").should("be.visible");
  cy.getCy("compliancemanagercompliance-title").should("be.visible");
  cy.getCy("compliancemanagercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [26/74 | 35%] - Saving screenshot for ComplianceManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [26/74 | 35%] - Verified ComplianceManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [27/74 | 36%] - Navigating to /management/compliance-manager-workflow (ComplianceManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/compliance-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [27/74 | 36%] - Checking shell & content for ComplianceManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagerworkflow-screen").should("be.visible");
  cy.getCy("compliancemanagerworkflow-title").should("be.visible");
  cy.getCy("compliancemanagerworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [27/74 | 36%] - Saving screenshot for ComplianceManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [27/74 | 36%] - Verified ComplianceManagerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [28/74 | 37%] - Navigating to /management/general-manager-compliance (GeneralManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/general-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [28/74 | 37%] - Checking shell & content for GeneralManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagercompliance-screen").should("be.visible");
  cy.getCy("generalmanagercompliance-title").should("be.visible");
  cy.getCy("generalmanagercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [28/74 | 37%] - Saving screenshot for GeneralManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("general_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [28/74 | 37%] - Verified GeneralManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [29/74 | 39%] - Navigating to /management/governance-officer-compliance (GovernanceOfficerComplianceScreen)...");
  cy.visitWithSemantics("/management/governance-officer-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [29/74 | 39%] - Checking shell & content for GovernanceOfficerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficercompliance-screen").should("be.visible");
  cy.getCy("governanceofficercompliance-title").should("be.visible");
  cy.getCy("governanceofficercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [29/74 | 39%] - Saving screenshot for GovernanceOfficerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("governance_officer_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [29/74 | 39%] - Verified GovernanceOfficerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [30/74 | 40%] - Navigating to /management/head-of-bus-dev-compliance (HeadOfBusDevComplianceScreen)...");
  cy.visitWithSemantics("/management/head-of-bus-dev-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [30/74 | 40%] - Checking shell & content for HeadOfBusDevComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofbusdevcompliance-screen").should("be.visible");
  cy.getCy("headofbusdevcompliance-title").should("be.visible");
  cy.getCy("headofbusdevcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [30/74 | 40%] - Saving screenshot for HeadOfBusDevComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_bus_dev_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [30/74 | 40%] - Verified HeadOfBusDevComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [31/74 | 41%] - Navigating to /management/head-of-marketing-compliance (HeadOfMarketingComplianceScreen)...");
  cy.visitWithSemantics("/management/head-of-marketing-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [31/74 | 41%] - Checking shell & content for HeadOfMarketingComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingcompliance-screen").should("be.visible");
  cy.getCy("headofmarketingcompliance-title").should("be.visible");
  cy.getCy("headofmarketingcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [31/74 | 41%] - Saving screenshot for HeadOfMarketingComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [31/74 | 41%] - Verified HeadOfMarketingComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [32/74 | 43%] - Navigating to /management/operations-manager-compliance (OperationsManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/operations-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [32/74 | 43%] - Checking shell & content for OperationsManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagercompliance-screen").should("be.visible");
  cy.getCy("operationsmanagercompliance-title").should("be.visible");
  cy.getCy("operationsmanagercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [32/74 | 43%] - Saving screenshot for OperationsManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [32/74 | 43%] - Verified OperationsManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [33/74 | 44%] - Navigating to /offices/clinical/roles/psw/help-support (PswComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/psw/help-support");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [33/74 | 44%] - Checking shell & content for PswComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcompliance-screen").should("be.visible");
  cy.getCy("pswcompliance-title").should("be.visible");
  cy.getCy("pswcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [33/74 | 44%] - Saving screenshot for PswComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("psw_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [33/74 | 44%] - Verified PswComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [34/74 | 45%] - Navigating to /offices/clinical/roles/rn/rn-compliance (RnComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/rn-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [34/74 | 45%] - Checking shell & content for RnComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncompliance-screen").should("be.visible");
  cy.getCy("rncompliance-title").should("be.visible");
  cy.getCy("rncompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [34/74 | 45%] - Saving screenshot for RnComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [34/74 | 45%] - Verified RnComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [35/74 | 47%] - Navigating to /offices/clinical/roles/rpn/rpn-compliance (RpnComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/rpn-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [35/74 | 47%] - Checking shell & content for RpnComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpncompliance-screen").should("be.visible");
  cy.getCy("rpncompliance-title").should("be.visible");
  cy.getCy("rpncompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [35/74 | 47%] - Saving screenshot for RpnComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("rpn_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [35/74 | 47%] - Verified RpnComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [36/74 | 48%] - Navigating to /staff/billing-admin-compliance (BillingAdminComplianceScreen)...");
  cy.visitWithSemantics("/staff/billing-admin-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [36/74 | 48%] - Checking shell & content for BillingAdminComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadmincompliance-screen").should("be.visible");
  cy.getCy("billingadmincompliance-title").should("be.visible");
  cy.getCy("billingadmincompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [36/74 | 48%] - Saving screenshot for BillingAdminComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_admin_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [36/74 | 48%] - Verified BillingAdminComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [37/74 | 50%] - Navigating to /staff/hr-hiring-compliance (HrHiringComplianceScreen)...");
  cy.visitWithSemantics("/staff/hr-hiring-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [37/74 | 50%] - Checking shell & content for HrHiringComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringcompliance-screen").should("be.visible");
  cy.getCy("hrhiringcompliance-title").should("be.visible");
  cy.getCy("hrhiringcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [37/74 | 50%] - Saving screenshot for HrHiringComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [37/74 | 50%] - Verified HrHiringComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [38/74 | 51%] - Navigating to /staff/hr-manager-compliance (HrManagerComplianceScreen)...");
  cy.visitWithSemantics("/staff/hr-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [38/74 | 51%] - Checking shell & content for HrManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagercompliance-screen").should("be.visible");
  cy.getCy("hrmanagercompliance-title").should("be.visible");
  cy.getCy("hrmanagercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [38/74 | 51%] - Saving screenshot for HrManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [38/74 | 51%] - Verified HrManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [39/74 | 52%] - Navigating to /offices/clinical/roles/intake_coordinator/coordinator-compliance (IntakeCoordinatorComplianceScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/intake_coordinator/coordinator-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [39/74 | 52%] - Checking shell & content for IntakeCoordinatorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorcompliance-screen").should("be.visible");
  cy.getCy("intakecoordinatorcompliance-title").should("be.visible");
  cy.getCy("intakecoordinatorcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [39/74 | 52%] - Saving screenshot for IntakeCoordinatorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [39/74 | 52%] - Verified IntakeCoordinatorComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [40/74 | 54%] - Navigating to /staff/quality-assurance-compliance (QualityAssuranceComplianceScreen)...");
  cy.visitWithSemantics("/staff/quality-assurance-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [40/74 | 54%] - Checking shell & content for QualityAssuranceComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancecompliance-screen").should("be.visible");
  cy.getCy("qualityassurancecompliance-title").should("be.visible");
  cy.getCy("qualityassurancecompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [40/74 | 54%] - Saving screenshot for QualityAssuranceComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [40/74 | 54%] - Verified QualityAssuranceComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [41/74 | 55%] - Navigating to /staff/receptionist-compliance (ReceptionistComplianceScreen)...");
  cy.visitWithSemantics("/staff/receptionist-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [41/74 | 55%] - Checking shell & content for ReceptionistComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistcompliance-screen").should("be.visible");
  cy.getCy("receptionistcompliance-title").should("be.visible");
  cy.getCy("receptionistcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [41/74 | 55%] - Saving screenshot for ReceptionistComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("receptionist_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [41/74 | 55%] - Verified ReceptionistComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [42/74 | 56%] - Navigating to /staff/scheduler-compliance (SchedulerComplianceScreen)...");
  cy.visitWithSemantics("/staff/scheduler-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [42/74 | 56%] - Checking shell & content for SchedulerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercompliance-screen").should("be.visible");
  cy.getCy("schedulercompliance-title").should("be.visible");
  cy.getCy("schedulercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [42/74 | 56%] - Saving screenshot for SchedulerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [42/74 | 56%] - Verified SchedulerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [43/74 | 58%] - Navigating to /offices/franchise/roles/franchise_owner/compliance (FranchiseOwnerComplianceScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/franchise_owner/compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [43/74 | 58%] - Checking shell & content for FranchiseOwnerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownercompliance-screen").should("be.visible");
  cy.getCy("franchiseownercompliance-title").should("be.visible");
  cy.getCy("franchiseownercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [43/74 | 58%] - Saving screenshot for FranchiseOwnerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [43/74 | 58%] - Verified FranchiseOwnerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [44/74 | 59%] - Navigating to /executive/tax-compliance (TaxComplianceScreen)...");
  cy.visitWithSemantics("/executive/tax-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [44/74 | 59%] - Checking shell & content for TaxComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("taxcompliance-screen").should("be.visible");
  cy.getCy("taxcompliance-title").should("be.visible");
  cy.getCy("taxcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [44/74 | 59%] - Saving screenshot for TaxComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("tax_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [44/74 | 59%] - Verified TaxComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [45/74 | 60%] - Navigating to /management/compliance-dashboard (ComplianceDashboardScreen)...");
  cy.visitWithSemantics("/management/compliance-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [45/74 | 60%] - Checking shell & content for ComplianceDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancedashboard-screen").should("be.visible");
  cy.getCy("compliancedashboard-title").should("be.visible");
  cy.getCy("compliancedashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [45/74 | 60%] - Saving screenshot for ComplianceDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [45/74 | 60%] - Verified ComplianceDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [46/74 | 62%] - Navigating to /management/audit-review (AuditReviewScreen)...");
  cy.visitWithSemantics("/management/audit-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [46/74 | 62%] - Checking shell & content for AuditReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("auditreview-screen").should("be.visible");
  cy.getCy("auditreview-title").should("be.visible");
  cy.getCy("auditreview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [46/74 | 62%] - Saving screenshot for AuditReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("audit_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [46/74 | 62%] - Verified AuditReviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [47/74 | 63%] - Navigating to /management/incident-management (IncidentManagementScreen)...");
  cy.visitWithSemantics("/management/incident-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [47/74 | 63%] - Checking shell & content for IncidentManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("incidentmanagement-screen").should("be.visible");
  cy.getCy("incidentmanagement-title").should("be.visible");
  cy.getCy("incidentmanagement-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [47/74 | 63%] - Saving screenshot for IncidentManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("incident_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [47/74 | 63%] - Verified IncidentManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [48/74 | 64%] - Navigating to /management/policy-management (PolicyManagementScreen)...");
  cy.visitWithSemantics("/management/policy-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [48/74 | 64%] - Checking shell & content for PolicyManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("policymanagement-screen").should("be.visible");
  cy.getCy("policymanagement-title").should("be.visible");
  cy.getCy("policymanagement-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [48/74 | 64%] - Saving screenshot for PolicyManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("policy_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [48/74 | 64%] - Verified PolicyManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [49/74 | 66%] - Navigating to /management/corrective-action (CorrectiveActionScreen)...");
  cy.visitWithSemantics("/management/corrective-action");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [49/74 | 66%] - Checking shell & content for CorrectiveActionScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("correctiveaction-screen").should("be.visible");
  cy.getCy("correctiveaction-title").should("be.visible");
  cy.getCy("correctiveaction-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [49/74 | 66%] - Saving screenshot for CorrectiveActionScreen...");
  cy.waitAndSee();
  cy.screenshot("corrective_action");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [49/74 | 66%] - Verified CorrectiveActionScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [50/74 | 67%] - Navigating to /executive/compliance-overview (ComplianceOverviewScreen)...");
  cy.visitWithSemantics("/executive/compliance-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [50/74 | 67%] - Checking shell & content for ComplianceOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("complianceoverview-screen").should("be.visible");
  cy.getCy("complianceoverview-title").should("be.visible");
  cy.getCy("complianceoverview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [50/74 | 67%] - Saving screenshot for ComplianceOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [50/74 | 67%] - Verified ComplianceOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [51/74 | 68%] - Navigating to /offices/corporate/roles/compliance_manager/audits (Audits)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/audits");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [51/74 | 68%] - Checking shell & content for Audits...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("audits-screen").should("be.visible");
  cy.getCy("audits-title").should("be.visible");
  cy.getCy("audits-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [51/74 | 68%] - Saving screenshot for Audits...");
  cy.waitAndSee();
  cy.screenshot("audits");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [51/74 | 68%] - Verified Audits successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [52/74 | 70%] - Navigating to /offices/corporate/roles/compliance_manager/compliance-cases (Compliance Cases)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/compliance-cases");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [52/74 | 70%] - Checking shell & content for Compliance Cases...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliance cases-screen").should("be.visible");
  cy.getCy("compliance cases-title").should("be.visible");
  cy.getCy("compliance cases-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [52/74 | 70%] - Saving screenshot for Compliance Cases...");
  cy.waitAndSee();
  cy.screenshot("compliance_cases");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [52/74 | 70%] - Verified Compliance Cases successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [53/74 | 71%] - Navigating to None (Compliance Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [53/74 | 71%] - Checking shell & content for Compliance Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliance reports-screen").should("be.visible");
  cy.getCy("compliance reports-title").should("be.visible");
  cy.getCy("compliance reports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [53/74 | 71%] - Saving screenshot for Compliance Reports...");
  cy.waitAndSee();
  cy.screenshot("compliance_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [53/74 | 71%] - Verified Compliance Reports successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [54/74 | 72%] - Navigating to /offices/corporate/roles/compliance_manager/corrective-actions (Corrective Actions)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/corrective-actions");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [54/74 | 72%] - Checking shell & content for Corrective Actions...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("corrective actions-screen").should("be.visible");
  cy.getCy("corrective actions-title").should("be.visible");
  cy.getCy("corrective actions-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [54/74 | 72%] - Saving screenshot for Corrective Actions...");
  cy.waitAndSee();
  cy.screenshot("corrective_actions");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [54/74 | 72%] - Verified Corrective Actions successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [55/74 | 74%] - Navigating to /offices/corporate/roles/compliance_manager/credential-tracking (Credential Tracking)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/credential-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [55/74 | 74%] - Checking shell & content for Credential Tracking...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("credential tracking-screen").should("be.visible");
  cy.getCy("credential tracking-title").should("be.visible");
  cy.getCy("credential tracking-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [55/74 | 74%] - Saving screenshot for Credential Tracking...");
  cy.waitAndSee();
  cy.screenshot("credential_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [55/74 | 74%] - Verified Credential Tracking successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [56/74 | 75%] - Navigating to /offices/corporate/roles/compliance_manager/document-expiry (Document Expiry)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/document-expiry");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [56/74 | 75%] - Checking shell & content for Document Expiry...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("document expiry-screen").should("be.visible");
  cy.getCy("document expiry-title").should("be.visible");
  cy.getCy("document expiry-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [56/74 | 75%] - Saving screenshot for Document Expiry...");
  cy.waitAndSee();
  cy.screenshot("document_expiry");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [56/74 | 75%] - Verified Document Expiry successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [57/74 | 77%] - Navigating to /offices/corporate/roles/compliance_manager/policies (Policies)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/policies");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [57/74 | 77%] - Checking shell & content for Policies...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("policies-screen").should("be.visible");
  cy.getCy("policies-title").should("be.visible");
  cy.getCy("policies-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [57/74 | 77%] - Saving screenshot for Policies...");
  cy.waitAndSee();
  cy.screenshot("policies");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [57/74 | 77%] - Verified Policies successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [58/74 | 78%] - Navigating to /offices/corporate/roles/compliance_manager/risk-register (Risk Register)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/risk-register");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [58/74 | 78%] - Checking shell & content for Risk Register...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("risk register-screen").should("be.visible");
  cy.getCy("risk register-title").should("be.visible");
  cy.getCy("risk register-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [58/74 | 78%] - Saving screenshot for Risk Register...");
  cy.waitAndSee();
  cy.screenshot("risk_register");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [58/74 | 78%] - Verified Risk Register successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [59/74 | 79%] - Navigating to /offices/corporate/roles/compliance_manager/training-compliance (Training Compliance)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/training-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [59/74 | 79%] - Checking shell & content for Training Compliance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("training compliance-screen").should("be.visible");
  cy.getCy("training compliance-title").should("be.visible");
  cy.getCy("training compliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [59/74 | 79%] - Saving screenshot for Training Compliance...");
  cy.waitAndSee();
  cy.screenshot("training_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [59/74 | 79%] - Verified Training Compliance successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [60/74 | 81%] - Navigating to None (Compliance Manager Audits)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [60/74 | 81%] - Checking shell & content for Compliance Manager Audits...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliance manager audits-screen").should("be.visible");
  cy.getCy("compliance manager audits-title").should("be.visible");
  cy.getCy("compliance manager audits-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [60/74 | 81%] - Saving screenshot for Compliance Manager Audits...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_audits");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [60/74 | 81%] - Verified Compliance Manager Audits successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [61/74 | 82%] - Navigating to None (Compliance Manager Compliance Cases)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [61/74 | 82%] - Checking shell & content for Compliance Manager Compliance Cases...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliance manager compliance cases-screen").should("be.visible");
  cy.getCy("compliance manager compliance cases-title").should("be.visible");
  cy.getCy("compliance manager compliance cases-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [61/74 | 82%] - Saving screenshot for Compliance Manager Compliance Cases...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_compliance_cases");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [61/74 | 82%] - Verified Compliance Manager Compliance Cases successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [62/74 | 83%] - Navigating to None (Compliance Manager Corrective Actions)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [62/74 | 83%] - Checking shell & content for Compliance Manager Corrective Actions...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliance manager corrective actions-screen").should("be.visible");
  cy.getCy("compliance manager corrective actions-title").should("be.visible");
  cy.getCy("compliance manager corrective actions-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [62/74 | 83%] - Saving screenshot for Compliance Manager Corrective Actions...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_corrective_actions");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [62/74 | 83%] - Verified Compliance Manager Corrective Actions successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [63/74 | 85%] - Navigating to None (Compliance Manager Credential Tracking)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [63/74 | 85%] - Checking shell & content for Compliance Manager Credential Tracking...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliance manager credential tracking-screen").should("be.visible");
  cy.getCy("compliance manager credential tracking-title").should("be.visible");
  cy.getCy("compliance manager credential tracking-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [63/74 | 85%] - Saving screenshot for Compliance Manager Credential Tracking...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_credential_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [63/74 | 85%] - Verified Compliance Manager Credential Tracking successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [64/74 | 86%] - Navigating to None (Compliance Manager Document Expiry)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [64/74 | 86%] - Checking shell & content for Compliance Manager Document Expiry...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliance manager document expiry-screen").should("be.visible");
  cy.getCy("compliance manager document expiry-title").should("be.visible");
  cy.getCy("compliance manager document expiry-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [64/74 | 86%] - Saving screenshot for Compliance Manager Document Expiry...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_document_expiry");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [64/74 | 86%] - Verified Compliance Manager Document Expiry successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [65/74 | 87%] - Navigating to /offices/corporate/roles/compliance_manager/incident-review (Compliance Manager Incident Review)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/incident-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [65/74 | 87%] - Checking shell & content for Compliance Manager Incident Review...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliance manager incident review-screen").should("be.visible");
  cy.getCy("compliance manager incident review-title").should("be.visible");
  cy.getCy("compliance manager incident review-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [65/74 | 87%] - Saving screenshot for Compliance Manager Incident Review...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_incident_review");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [65/74 | 87%] - Verified Compliance Manager Incident Review successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [66/74 | 89%] - Navigating to None (Compliance Manager Policies)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [66/74 | 89%] - Checking shell & content for Compliance Manager Policies...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliance manager policies-screen").should("be.visible");
  cy.getCy("compliance manager policies-title").should("be.visible");
  cy.getCy("compliance manager policies-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [66/74 | 89%] - Saving screenshot for Compliance Manager Policies...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_policies");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [66/74 | 89%] - Verified Compliance Manager Policies successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [67/74 | 90%] - Navigating to /offices/corporate/roles/compliance_manager/reports (Compliance Manager Reports)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [67/74 | 90%] - Checking shell & content for Compliance Manager Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliance manager reports-screen").should("be.visible");
  cy.getCy("compliance manager reports-title").should("be.visible");
  cy.getCy("compliance manager reports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [67/74 | 90%] - Saving screenshot for Compliance Manager Reports...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [67/74 | 90%] - Verified Compliance Manager Reports successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [68/74 | 91%] - Navigating to None (Compliance Manager Risk Register)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [68/74 | 91%] - Checking shell & content for Compliance Manager Risk Register...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliance manager risk register-screen").should("be.visible");
  cy.getCy("compliance manager risk register-title").should("be.visible");
  cy.getCy("compliance manager risk register-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [68/74 | 91%] - Saving screenshot for Compliance Manager Risk Register...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_risk_register");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [68/74 | 91%] - Verified Compliance Manager Risk Register successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [69/74 | 93%] - Navigating to None (Compliance Manager Training Compliance)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [69/74 | 93%] - Checking shell & content for Compliance Manager Training Compliance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliance manager training compliance-screen").should("be.visible");
  cy.getCy("compliance manager training compliance-title").should("be.visible");
  cy.getCy("compliance manager training compliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [69/74 | 93%] - Saving screenshot for Compliance Manager Training Compliance...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_training_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [69/74 | 93%] - Verified Compliance Manager Training Compliance successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [70/74 | 94%] - Navigating to None (Compliance Training)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [70/74 | 94%] - Checking shell & content for Compliance Training...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliance training-screen").should("be.visible");
  cy.getCy("compliance training-title").should("be.visible");
  cy.getCy("compliance training-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [70/74 | 94%] - Saving screenshot for Compliance Training...");
  cy.waitAndSee();
  cy.screenshot("compliance_training");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [70/74 | 94%] - Verified Compliance Training successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [71/74 | 95%] - Navigating to /generated/compliance-reviews (Compliance Reviews)...");
  cy.visitWithSemantics("/generated/compliance-reviews");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [71/74 | 95%] - Checking shell & content for Compliance Reviews...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliance reviews-screen").should("be.visible");
  cy.getCy("compliance reviews-title").should("be.visible");
  cy.getCy("compliance reviews-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [71/74 | 95%] - Saving screenshot for Compliance Reviews...");
  cy.waitAndSee();
  cy.screenshot("compliance_reviews");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [71/74 | 95%] - Verified Compliance Reviews successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [72/74 | 97%] - Navigating to None (Quality Assurance Compliance Checks)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [72/74 | 97%] - Checking shell & content for Quality Assurance Compliance Checks...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("quality assurance compliance checks-screen").should("be.visible");
  cy.getCy("quality assurance compliance checks-title").should("be.visible");
  cy.getCy("quality assurance compliance checks-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [72/74 | 97%] - Saving screenshot for Quality Assurance Compliance Checks...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_compliance_checks");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [72/74 | 97%] - Verified Quality Assurance Compliance Checks successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [73/74 | 98%] - Navigating to None (Compliance Training Tracker)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [73/74 | 98%] - Checking shell & content for Compliance Training Tracker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliance training tracker-screen").should("be.visible");
  cy.getCy("compliance training tracker-title").should("be.visible");
  cy.getCy("compliance training tracker-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [73/74 | 98%] - Saving screenshot for Compliance Training Tracker...");
  cy.waitAndSee();
  cy.screenshot("compliance_training_tracker");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [73/74 | 98%] - Verified Compliance Training Tracker successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [74/74 | 100%] - Navigating to None (Formulary Compliance Manager)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [74/74 | 100%] - Checking shell & content for Formulary Compliance Manager...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("formulary compliance manager-screen").should("be.visible");
  cy.getCy("formulary compliance manager-title").should("be.visible");
  cy.getCy("formulary compliance manager-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [74/74 | 100%] - Saving screenshot for Formulary Compliance Manager...");
  cy.waitAndSee();
  cy.screenshot("formulary_compliance_manager");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [74/74 | 100%] - Verified Formulary Compliance Manager successfully!\n");

  });
});
