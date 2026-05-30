// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - family", () => {
  it("tests all screens for role family", () => {
    cy.loginAsRole("family");


  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Navigating to /common/family-member-analytics (FamilyMemberAnalyticsScreen)...");
  cy.visitWithSemantics("/common/family-member-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Checking shell & content for FamilyMemberAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberanalytics-screen").should("be.visible");
  cy.getCy("familymemberanalytics-title").should("be.visible");
  cy.getCy("familymemberanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Saving screenshot for FamilyMemberAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/7 | 14%] - Verified FamilyMemberAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Navigating to /common/family-member-compliance (FamilyMemberComplianceScreen)...");
  cy.visitWithSemantics("/common/family-member-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Checking shell & content for FamilyMemberComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymembercompliance-screen").should("be.visible");
  cy.getCy("familymembercompliance-title").should("be.visible");
  cy.getCy("familymembercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Saving screenshot for FamilyMemberComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [2/7 | 28%] - Verified FamilyMemberComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Navigating to /common/family-member-workflow (FamilyMemberWorkflowScreen)...");
  cy.visitWithSemantics("/common/family-member-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Checking shell & content for FamilyMemberWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberworkflow-screen").should("be.visible");
  cy.getCy("familymemberworkflow-title").should("be.visible");
  cy.getCy("familymemberworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Saving screenshot for FamilyMemberWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("family_member_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [3/7 | 42%] - Verified FamilyMemberWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Navigating to /common/family-overview (FamilyOverviewScreen)...");
  cy.visitWithSemantics("/common/family-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Checking shell & content for FamilyOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familyoverview-screen").should("be.visible");
  cy.getCy("familyoverview-title").should("be.visible");
  cy.getCy("familyoverview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Saving screenshot for FamilyOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("family_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [4/7 | 57%] - Verified FamilyOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Navigating to /common/care-updates (CareUpdatesScreen)...");
  cy.visitWithSemantics("/common/care-updates");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Checking shell & content for CareUpdatesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("careupdates-screen").should("be.visible");
  cy.getCy("careupdates-title").should("be.visible");
  cy.getCy("careupdates-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Saving screenshot for CareUpdatesScreen...");
  cy.waitAndSee();
  cy.screenshot("care_updates");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [5/7 | 71%] - Verified CareUpdatesScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Navigating to /common/billing-overview (BillingOverviewScreen)...");
  cy.visitWithSemantics("/common/billing-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Checking shell & content for BillingOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingoverview-screen").should("be.visible");
  cy.getCy("billingoverview-title").should("be.visible");
  cy.getCy("billingoverview-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Saving screenshot for BillingOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_overview");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [6/7 | 85%] - Verified BillingOverviewScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Navigating to /common/emergency-contacts (EmergencyContactsScreen)...");
  cy.visitWithSemantics("/common/emergency-contacts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Checking shell & content for EmergencyContactsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("emergencycontacts-screen").should("be.visible");
  cy.getCy("emergencycontacts-title").should("be.visible");
  cy.getCy("emergencycontacts-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Saving screenshot for EmergencyContactsScreen...");
  cy.waitAndSee();
  cy.screenshot("emergency_contacts");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [7/7 | 100%] - Verified EmergencyContactsScreen successfully!\n");

  });
});
