// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - community_outreach", () => {
  it("tests all screens for role community_outreach", () => {
    cy.loginAsRole("community_outreach");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Navigating to /offices/marketing/roles/community_outreach/dashboard (CommunityOutreachDashboardScreen)...");
  cy.visitWithSemantics("/offices/marketing/roles/community_outreach/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Checking shell & content for CommunityOutreachDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachdashboard-screen").should("be.visible");
  cy.getCy("communityoutreachdashboard-title").should("be.visible");
  cy.getCy("communityoutreachdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Saving screenshot for CommunityOutreachDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/11 | 9%] - Verified CommunityOutreachDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Navigating to /management/community-outreach-analytics (CommunityOutreachAnalyticsScreen)...");
  cy.visitWithSemantics("/management/community-outreach-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Checking shell & content for CommunityOutreachAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachanalytics-screen").should("be.visible");
  cy.getCy("communityoutreachanalytics-title").should("be.visible");
  cy.getCy("communityoutreachanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Saving screenshot for CommunityOutreachAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/11 | 18%] - Verified CommunityOutreachAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Navigating to /management/community-outreach-compliance (CommunityOutreachComplianceScreen)...");
  cy.visitWithSemantics("/management/community-outreach-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Checking shell & content for CommunityOutreachComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachcompliance-screen").should("be.visible");
  cy.getCy("communityoutreachcompliance-title").should("be.visible");
  cy.getCy("communityoutreachcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Saving screenshot for CommunityOutreachComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/11 | 27%] - Verified CommunityOutreachComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Navigating to /management/community-outreach-workflow (CommunityOutreachWorkflowScreen)...");
  cy.visitWithSemantics("/management/community-outreach-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Checking shell & content for CommunityOutreachWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachworkflow-screen").should("be.visible");
  cy.getCy("communityoutreachworkflow-title").should("be.visible");
  cy.getCy("communityoutreachworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Saving screenshot for CommunityOutreachWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/11 | 36%] - Verified CommunityOutreachWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Navigating to None (Community Outreach Contacts)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Checking shell & content for Community Outreach Contacts...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("community outreach contacts-screen").should("be.visible");
  cy.getCy("community outreach contacts-title").should("be.visible");
  cy.getCy("community outreach contacts-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Saving screenshot for Community Outreach Contacts...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_contacts");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/11 | 45%] - Verified Community Outreach Contacts successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Navigating to None (Community Outreach Events)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Checking shell & content for Community Outreach Events...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("community outreach events-screen").should("be.visible");
  cy.getCy("community outreach events-title").should("be.visible");
  cy.getCy("community outreach events-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Saving screenshot for Community Outreach Events...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_events");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/11 | 54%] - Verified Community Outreach Events successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Navigating to None (Community Outreach Follow Ups)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Checking shell & content for Community Outreach Follow Ups...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("community outreach follow ups-screen").should("be.visible");
  cy.getCy("community outreach follow ups-title").should("be.visible");
  cy.getCy("community outreach follow ups-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Saving screenshot for Community Outreach Follow Ups...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_follow_ups");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [7/11 | 63%] - Verified Community Outreach Follow Ups successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Navigating to None (Community Outreach Partnerships)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Checking shell & content for Community Outreach Partnerships...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("community outreach partnerships-screen").should("be.visible");
  cy.getCy("community outreach partnerships-title").should("be.visible");
  cy.getCy("community outreach partnerships-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Saving screenshot for Community Outreach Partnerships...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_partnerships");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [8/11 | 72%] - Verified Community Outreach Partnerships successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Navigating to None (Community Outreach Programs)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Checking shell & content for Community Outreach Programs...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("community outreach programs-screen").should("be.visible");
  cy.getCy("community outreach programs-title").should("be.visible");
  cy.getCy("community outreach programs-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Saving screenshot for Community Outreach Programs...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_programs");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [9/11 | 81%] - Verified Community Outreach Programs successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Navigating to None (Community Outreach Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Checking shell & content for Community Outreach Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("community outreach reports-screen").should("be.visible");
  cy.getCy("community outreach reports-title").should("be.visible");
  cy.getCy("community outreach reports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Saving screenshot for Community Outreach Reports...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [10/11 | 90%] - Verified Community Outreach Reports successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Navigating to None (Community Outreach Volunteers)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Checking shell & content for Community Outreach Volunteers...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("community outreach volunteers-screen").should("be.visible");
  cy.getCy("community outreach volunteers-title").should("be.visible");
  cy.getCy("community outreach volunteers-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Saving screenshot for Community Outreach Volunteers...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_volunteers");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [11/11 | 100%] - Verified Community Outreach Volunteers successfully!\n");

  });
});
