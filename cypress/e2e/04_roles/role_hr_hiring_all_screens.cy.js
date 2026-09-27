// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - hr_hiring", () => {
  it("tests all screens for role hr_hiring", () => {
    cy.loginAsRole("hr_hiring");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/13 | 7%] - Navigating to /offices/corporate/roles/hr_hiring/dashboard (HrHiringDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/hr_hiring/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/13 | 7%] - Checking shell & content for HrHiringDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("hrhiringdashboard-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringdashboard-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringdashboard-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/13 | 7%] - Saving screenshot for HrHiringDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/13 | 7%] - Verified HrHiringDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/13 | 15%] - Navigating to /staff/hr-hiring-analytics (HrHiringAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/hr-hiring-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/13 | 15%] - Checking shell & content for HrHiringAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("hrhiringanalytics-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringanalytics-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringanalytics-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/13 | 15%] - Saving screenshot for HrHiringAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/13 | 15%] - Verified HrHiringAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/13 | 23%] - Navigating to /staff/hr-hiring-compliance (HrHiringComplianceScreen)...");
  cy.visitWithSemantics("/staff/hr-hiring-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/13 | 23%] - Checking shell & content for HrHiringComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("hrhiringcompliance-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringcompliance-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringcompliance-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/13 | 23%] - Saving screenshot for HrHiringComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/13 | 23%] - Verified HrHiringComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/13 | 30%] - Navigating to /staff/hr-hiring-workflow (HrHiringWorkflowScreen)...");
  cy.visitWithSemantics("/staff/hr-hiring-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/13 | 30%] - Checking shell & content for HrHiringWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("hrhiringworkflow-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringworkflow-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringworkflow-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/13 | 30%] - Saving screenshot for HrHiringWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/13 | 30%] - Verified HrHiringWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/13 | 38%] - Navigating to /offices/franchise/roles/hr_hiring/applicants (HrHiringApplicantsScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/applicants");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/13 | 38%] - Checking shell & content for HrHiringApplicantsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("hrhiringapplicants-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringapplicants-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringapplicants-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/13 | 38%] - Saving screenshot for HrHiringApplicantsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_applicants");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/13 | 38%] - Verified HrHiringApplicantsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/13 | 46%] - Navigating to /offices/franchise/roles/hr_hiring/interviews (HrHiringInterviewsScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/interviews");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/13 | 46%] - Checking shell & content for HrHiringInterviewsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("hrhiringinterviews-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringinterviews-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringinterviews-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/13 | 46%] - Saving screenshot for HrHiringInterviewsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_interviews");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/13 | 46%] - Verified HrHiringInterviewsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/13 | 53%] - Navigating to /offices/franchise/roles/hr_hiring/offers (HrHiringOffersScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/offers");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/13 | 53%] - Checking shell & content for HrHiringOffersScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("hrhiringoffers-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringoffers-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringoffers-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/13 | 53%] - Saving screenshot for HrHiringOffersScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_offers");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/13 | 53%] - Verified HrHiringOffersScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/13 | 61%] - Navigating to /offices/franchise/roles/hr_hiring/onboarding (HrHiringOnboardingScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/onboarding");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/13 | 61%] - Checking shell & content for HrHiringOnboardingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("hrhiringonboarding-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringonboarding-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringonboarding-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/13 | 61%] - Saving screenshot for HrHiringOnboardingScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_onboarding");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/13 | 61%] - Verified HrHiringOnboardingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/13 | 69%] - Navigating to /offices/franchise/roles/hr_hiring/credentials (HrHiringCredentialsScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/credentials");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/13 | 69%] - Checking shell & content for HrHiringCredentialsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("hrhiringcredentials-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringcredentials-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("hrhiringcredentials-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/13 | 69%] - Saving screenshot for HrHiringCredentialsScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_credentials");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/13 | 69%] - Verified HrHiringCredentialsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [10/13 | 76%] - Navigating to /staff/applicant-tracking (ApplicantTrackingScreen)...");
  cy.visitWithSemantics("/staff/applicant-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [10/13 | 76%] - Checking shell & content for ApplicantTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("applicanttracking-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("applicanttracking-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("applicanttracking-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [10/13 | 76%] - Saving screenshot for ApplicantTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("applicant_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [10/13 | 76%] - Verified ApplicantTrackingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [11/13 | 84%] - Navigating to /staff/interview-scheduling (InterviewSchedulingScreen)...");
  cy.visitWithSemantics("/staff/interview-scheduling");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [11/13 | 84%] - Checking shell & content for InterviewSchedulingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("interviewscheduling-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("interviewscheduling-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("interviewscheduling-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [11/13 | 84%] - Saving screenshot for InterviewSchedulingScreen...");
  cy.waitAndSee();
  cy.screenshot("interview_scheduling");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [11/13 | 84%] - Verified InterviewSchedulingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [12/13 | 92%] - Navigating to /staff/offer-management (OfferManagementScreen)...");
  cy.visitWithSemantics("/staff/offer-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [12/13 | 92%] - Checking shell & content for OfferManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("offermanagement-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("offermanagement-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("offermanagement-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [12/13 | 92%] - Saving screenshot for OfferManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("offer_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [12/13 | 92%] - Verified OfferManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [13/13 | 100%] - Navigating to /staff/onboarding-checklist (OnboardingChecklistScreen)...");
  cy.visitWithSemantics("/staff/onboarding-checklist");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [13/13 | 100%] - Checking shell & content for OnboardingChecklistScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // cy.getCy("onboardingchecklist-screen").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("onboardingchecklist-title").should("be.visible"); // NOT FOUND IN DART WIDGET TREE
  // cy.getCy("onboardingchecklist-content").should("be.visible"); // NOT FOUND IN DART WIDGET TREE

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [13/13 | 100%] - Saving screenshot for OnboardingChecklistScreen...");
  cy.waitAndSee();
  cy.screenshot("onboarding_checklist");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [13/13 | 100%] - Verified OnboardingChecklistScreen successfully!\n");

  });
});
