// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - franchise_sales", () => {
  it("tests all screens for role franchise_sales", () => {
    cy.loginAsRole("franchise_sales");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/14 | 7%] - Navigating to /offices/business_development/roles/franchise_sales_manager/dashboard (FranchiseSalesManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/14 | 7%] - Checking shell & content for FranchiseSalesManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerdashboard-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerdashboard-title").should("be.visible");
  cy.getCy("franchisesalesmanagerdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/14 | 7%] - Saving screenshot for FranchiseSalesManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/14 | 7%] - Verified FranchiseSalesManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/14 | 14%] - Navigating to /management/franchise-sales-manager-analytics (FranchiseSalesManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/franchise-sales-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/14 | 14%] - Checking shell & content for FranchiseSalesManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanageranalytics-screen").should("be.visible");
  cy.getCy("franchisesalesmanageranalytics-title").should("be.visible");
  cy.getCy("franchisesalesmanageranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/14 | 14%] - Saving screenshot for FranchiseSalesManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/14 | 14%] - Verified FranchiseSalesManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/14 | 21%] - Navigating to /management/franchise-sales-manager-compliance (FranchiseSalesManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/franchise-sales-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/14 | 21%] - Checking shell & content for FranchiseSalesManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagercompliance-screen").should("be.visible");
  cy.getCy("franchisesalesmanagercompliance-title").should("be.visible");
  cy.getCy("franchisesalesmanagercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/14 | 21%] - Saving screenshot for FranchiseSalesManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/14 | 21%] - Verified FranchiseSalesManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/14 | 28%] - Navigating to /management/franchise-sales-manager-workflow (FranchiseSalesManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/franchise-sales-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/14 | 28%] - Checking shell & content for FranchiseSalesManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerworkflow-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerworkflow-title").should("be.visible");
  cy.getCy("franchisesalesmanagerworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/14 | 28%] - Saving screenshot for FranchiseSalesManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/14 | 28%] - Verified FranchiseSalesManagerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/14 | 35%] - Navigating to /executive/franchise-sales-analytics (Franchise Sales Manager Analytics)...");
  cy.visitWithSemantics("/executive/franchise-sales-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/14 | 35%] - Checking shell & content for Franchise Sales Manager Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager analytics-screen").should("be.visible");
  cy.getCy("franchise sales manager analytics-title").should("be.visible");
  cy.getCy("franchise sales manager analytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/14 | 35%] - Saving screenshot for Franchise Sales Manager Analytics...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/14 | 35%] - Verified Franchise Sales Manager Analytics successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/14 | 42%] - Navigating to /executive/franchise-sales-workflow (Franchise Sales Manager Compliance Workflow)...");
  cy.visitWithSemantics("/executive/franchise-sales-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/14 | 42%] - Checking shell & content for Franchise Sales Manager Compliance Workflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager compliance workflow-screen").should("be.visible");
  cy.getCy("franchise sales manager compliance workflow-title").should("be.visible");
  cy.getCy("franchise sales manager compliance workflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/14 | 42%] - Saving screenshot for Franchise Sales Manager Compliance Workflow...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [6/14 | 42%] - Verified Franchise Sales Manager Compliance Workflow successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/14 | 50%] - Navigating to /offices/business_development/roles/franchise_sales_manager/contracts (Franchise Sales Manager Contracts)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/contracts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/14 | 50%] - Checking shell & content for Franchise Sales Manager Contracts...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager contracts-screen").should("be.visible");
  cy.getCy("franchise sales manager contracts-title").should("be.visible");
  cy.getCy("franchise sales manager contracts-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/14 | 50%] - Saving screenshot for Franchise Sales Manager Contracts...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_contracts");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/14 | 50%] - Verified Franchise Sales Manager Contracts successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/14 | 57%] - Navigating to /offices/business_development/roles/franchise_sales_manager/discovery-calls (Franchise Sales Manager Discovery Calls)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/discovery-calls");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/14 | 57%] - Checking shell & content for Franchise Sales Manager Discovery Calls...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager discovery calls-screen").should("be.visible");
  cy.getCy("franchise sales manager discovery calls-title").should("be.visible");
  cy.getCy("franchise sales manager discovery calls-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/14 | 57%] - Saving screenshot for Franchise Sales Manager Discovery Calls...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_discovery_calls");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/14 | 57%] - Verified Franchise Sales Manager Discovery Calls successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/14 | 64%] - Navigating to /offices/business_development/roles/franchise_sales_manager/follow-ups (Franchise Sales Manager Follow Ups)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/follow-ups");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/14 | 64%] - Checking shell & content for Franchise Sales Manager Follow Ups...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager follow ups-screen").should("be.visible");
  cy.getCy("franchise sales manager follow ups-title").should("be.visible");
  cy.getCy("franchise sales manager follow ups-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/14 | 64%] - Saving screenshot for Franchise Sales Manager Follow Ups...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_follow_ups");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [9/14 | 64%] - Verified Franchise Sales Manager Follow Ups successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [10/14 | 71%] - Navigating to /offices/business_development/roles/franchise_sales_manager/leads (Franchise Sales Manager Leads)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/leads");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [10/14 | 71%] - Checking shell & content for Franchise Sales Manager Leads...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager leads-screen").should("be.visible");
  cy.getCy("franchise sales manager leads-title").should("be.visible");
  cy.getCy("franchise sales manager leads-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [10/14 | 71%] - Saving screenshot for Franchise Sales Manager Leads...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_leads");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [10/14 | 71%] - Verified Franchise Sales Manager Leads successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/14 | 78%] - Navigating to /offices/business_development/roles/franchise_sales_manager/proposals (Franchise Sales Manager Proposals)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/proposals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/14 | 78%] - Checking shell & content for Franchise Sales Manager Proposals...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager proposals-screen").should("be.visible");
  cy.getCy("franchise sales manager proposals-title").should("be.visible");
  cy.getCy("franchise sales manager proposals-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/14 | 78%] - Saving screenshot for Franchise Sales Manager Proposals...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_proposals");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [11/14 | 78%] - Verified Franchise Sales Manager Proposals successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/14 | 85%] - Navigating to /offices/business_development/roles/franchise_sales_manager/prospects (Franchise Sales Manager Prospects)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/prospects");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/14 | 85%] - Checking shell & content for Franchise Sales Manager Prospects...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager prospects-screen").should("be.visible");
  cy.getCy("franchise sales manager prospects-title").should("be.visible");
  cy.getCy("franchise sales manager prospects-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/14 | 85%] - Saving screenshot for Franchise Sales Manager Prospects...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_prospects");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [12/14 | 85%] - Verified Franchise Sales Manager Prospects successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [13/14 | 92%] - Navigating to /offices/business_development/roles/franchise_sales_manager/reports (Franchise Sales Manager Reports)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [13/14 | 92%] - Checking shell & content for Franchise Sales Manager Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager reports-screen").should("be.visible");
  cy.getCy("franchise sales manager reports-title").should("be.visible");
  cy.getCy("franchise sales manager reports-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [13/14 | 92%] - Saving screenshot for Franchise Sales Manager Reports...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_reports");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [13/14 | 92%] - Verified Franchise Sales Manager Reports successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [14/14 | 100%] - Navigating to /offices/business_development/roles/franchise_sales_manager/sales-pipeline (Franchise Sales Manager Sales Pipeline)...");
  cy.visitWithSemantics("/offices/business_development/roles/franchise_sales_manager/sales-pipeline");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [14/14 | 100%] - Checking shell & content for Franchise Sales Manager Sales Pipeline...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager sales pipeline-screen").should("be.visible");
  cy.getCy("franchise sales manager sales pipeline-title").should("be.visible");
  cy.getCy("franchise sales manager sales pipeline-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [14/14 | 100%] - Saving screenshot for Franchise Sales Manager Sales Pipeline...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_sales_pipeline");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [14/14 | 100%] - Verified Franchise Sales Manager Sales Pipeline successfully!\n");

  });
});
