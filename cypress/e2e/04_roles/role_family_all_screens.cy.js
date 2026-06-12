// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - family", () => {
  it("tests all screens for role family", () => {
    cy.loginAsRole("family");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Navigating to /common/family-member-dashboard (FamilyMemberDashboardScreen)...");
  cy.visitWithSemantics("/common/family-member-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Checking shell & content for FamilyMemberDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberdashboard-screen").should("be.visible");
  cy.getCy("familymemberdashboard-title").should("be.visible");
  cy.getCy("familymemberdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Saving screenshot for FamilyMemberDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/18 | 5%] - Verified FamilyMemberDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Navigating to /common/family-member-analytics (FamilyMemberAnalyticsScreen)...");
  cy.visitWithSemantics("/common/family-member-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Checking shell & content for FamilyMemberAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberanalytics-screen").should("be.visible");
  cy.getCy("familymemberanalytics-title").should("be.visible");
  cy.getCy("familymemberanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Saving screenshot for FamilyMemberAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/18 | 11%] - Verified FamilyMemberAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Navigating to /common/family-member-workflow (FamilyMemberWorkflowScreen)...");
  cy.visitWithSemantics("/common/family-member-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Checking shell & content for FamilyMemberWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberworkflow-screen").should("be.visible");
  cy.getCy("familymemberworkflow-title").should("be.visible");
  cy.getCy("familymemberworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Saving screenshot for FamilyMemberWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/18 | 16%] - Verified FamilyMemberWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Navigating to /common/family-overview (FamilyOverviewScreen)...");
  cy.visitWithSemantics("/common/family-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Checking shell & content for FamilyOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familyoverview-screen").should("be.visible");
  cy.getCy("familyoverview-title").should("be.visible");
  cy.getCy("familyoverview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Saving screenshot for FamilyOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("family_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/18 | 22%] - Verified FamilyOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Navigating to /common/care-updates (CareUpdatesScreen)...");
  cy.visitWithSemantics("/common/care-updates");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Checking shell & content for CareUpdatesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("careupdates-screen").should("be.visible");
  cy.getCy("careupdates-title").should("be.visible");
  cy.getCy("careupdates-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Saving screenshot for CareUpdatesScreen...");
  cy.waitAndSee();
  cy.screenshot("care_updates");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [5/18 | 27%] - Verified CareUpdatesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Navigating to /common/billing-overview (BillingOverviewScreen)...");
  cy.visitWithSemantics("/common/billing-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Checking shell & content for BillingOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingoverview-screen").should("be.visible");
  cy.getCy("billingoverview-title").should("be.visible");
  cy.getCy("billingoverview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Saving screenshot for BillingOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/18 | 33%] - Verified BillingOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Navigating to /common/emergency-contacts (EmergencyContactsScreen)...");
  cy.visitWithSemantics("/common/emergency-contacts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Checking shell & content for EmergencyContactsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("emergencycontacts-screen").should("be.visible");
  cy.getCy("emergencycontacts-title").should("be.visible");
  cy.getCy("emergencycontacts-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Saving screenshot for EmergencyContactsScreen...");
  cy.waitAndSee();
  cy.screenshot("emergency_contacts");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [7/18 | 38%] - Verified EmergencyContactsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Navigating to /offices/client/roles/family_member/billing (Family Billing)...");
  cy.visitWithSemantics("/offices/client/roles/family_member/billing");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Checking shell & content for Family Billing...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("family billing-screen").should("be.visible");
  cy.getCy("family billing-title").should("be.visible");
  cy.getCy("family billing-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Saving screenshot for Family Billing...");
  cy.waitAndSee();
  cy.screenshot("family_billing");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [8/18 | 44%] - Verified Family Billing successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Navigating to /offices/client/roles/family_member/care-updates (Family Care Updates)...");
  cy.visitWithSemantics("/offices/client/roles/family_member/care-updates");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Checking shell & content for Family Care Updates...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("family care updates-screen").should("be.visible");
  cy.getCy("family care updates-title").should("be.visible");
  cy.getCy("family care updates-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Saving screenshot for Family Care Updates...");
  cy.waitAndSee();
  cy.screenshot("family_care_updates");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/18 | 50%] - Verified Family Care Updates successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Navigating to /offices/client/roles/family_member/dashboard (Family Dashboard)...");
  cy.visitWithSemantics("/offices/client/roles/family_member/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Checking shell & content for Family Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("family dashboard-screen").should("be.visible");
  cy.getCy("family dashboard-title").should("be.visible");
  cy.getCy("family dashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Saving screenshot for Family Dashboard...");
  cy.waitAndSee();
  cy.screenshot("family_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [10/18 | 55%] - Verified Family Dashboard successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Navigating to /offices/client/roles/family_member/emergency-contacts (Family Emergency Contacts)...");
  cy.visitWithSemantics("/offices/client/roles/family_member/emergency-contacts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Checking shell & content for Family Emergency Contacts...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("family emergency contacts-screen").should("be.visible");
  cy.getCy("family emergency contacts-title").should("be.visible");
  cy.getCy("family emergency contacts-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Saving screenshot for Family Emergency Contacts...");
  cy.waitAndSee();
  cy.screenshot("family_emergency_contacts");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/18 | 61%] - Verified Family Emergency Contacts successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Navigating to /offices/client/roles/family_member/loved-one-schedule (Family Loved One Schedule)...");
  cy.visitWithSemantics("/offices/client/roles/family_member/loved-one-schedule");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Checking shell & content for Family Loved One Schedule...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("family loved one schedule-screen").should("be.visible");
  cy.getCy("family loved one schedule-title").should("be.visible");
  cy.getCy("family loved one schedule-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Saving screenshot for Family Loved One Schedule...");
  cy.waitAndSee();
  cy.screenshot("family_loved_one_schedule");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [12/18 | 66%] - Verified Family Loved One Schedule successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Navigating to /offices/client/roles/family_member/profile (Family Profile)...");
  cy.visitWithSemantics("/offices/client/roles/family_member/profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Checking shell & content for Family Profile...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("family profile-screen").should("be.visible");
  cy.getCy("family profile-title").should("be.visible");
  cy.getCy("family profile-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Saving screenshot for Family Profile...");
  cy.waitAndSee();
  cy.screenshot("family_profile");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [13/18 | 72%] - Verified Family Profile successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Navigating to None (Family Member Billing)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Checking shell & content for Family Member Billing...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("family member billing-screen").should("be.visible");
  cy.getCy("family member billing-title").should("be.visible");
  cy.getCy("family member billing-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Saving screenshot for Family Member Billing...");
  cy.waitAndSee();
  cy.screenshot("family_member_billing");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [14/18 | 77%] - Verified Family Member Billing successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Navigating to None (Family Member Care Updates)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Checking shell & content for Family Member Care Updates...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("family member care updates-screen").should("be.visible");
  cy.getCy("family member care updates-title").should("be.visible");
  cy.getCy("family member care updates-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Saving screenshot for Family Member Care Updates...");
  cy.waitAndSee();
  cy.screenshot("family_member_care_updates");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [15/18 | 83%] - Verified Family Member Care Updates successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Navigating to None (Family Member Emergency Contacts)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Checking shell & content for Family Member Emergency Contacts...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("family member emergency contacts-screen").should("be.visible");
  cy.getCy("family member emergency contacts-title").should("be.visible");
  cy.getCy("family member emergency contacts-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Saving screenshot for Family Member Emergency Contacts...");
  cy.waitAndSee();
  cy.screenshot("family_member_emergency_contacts");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [16/18 | 88%] - Verified Family Member Emergency Contacts successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Navigating to None (Family Member Loved One Schedule)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Checking shell & content for Family Member Loved One Schedule...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("family member loved one schedule-screen").should("be.visible");
  cy.getCy("family member loved one schedule-title").should("be.visible");
  cy.getCy("family member loved one schedule-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Saving screenshot for Family Member Loved One Schedule...");
  cy.waitAndSee();
  cy.screenshot("family_member_loved_one_schedule");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [17/18 | 94%] - Verified Family Member Loved One Schedule successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Navigating to None (Family Member Profile)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Checking shell & content for Family Member Profile...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("family member profile-screen").should("be.visible");
  cy.getCy("family member profile-title").should("be.visible");
  cy.getCy("family member profile-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Saving screenshot for Family Member Profile...");
  cy.waitAndSee();
  cy.screenshot("family_member_profile");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [18/18 | 100%] - Verified Family Member Profile successfully!\n");

  });
});
