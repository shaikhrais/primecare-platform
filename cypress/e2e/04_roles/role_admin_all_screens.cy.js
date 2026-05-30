// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - admin", () => {
  it("tests all screens for role admin", () => {
    cy.loginAsRole("admin");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Navigating to /common/office-dashboard (OfficeDashboardScreen)...");
  cy.visitWithSemantics("/common/office-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Checking shell & content for OfficeDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officedashboard-screen").should("be.visible");
  cy.getCy("officedashboard-title").should("be.visible");
  cy.getCy("officedashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Saving screenshot for OfficeDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("office_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/16 | 6%] - Verified OfficeDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Navigating to /staff/billing-admin-dashboard (BillingAdminDashboardScreen)...");
  cy.visitWithSemantics("/staff/billing-admin-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Checking shell & content for BillingAdminDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadmindashboard-screen").should("be.visible");
  cy.getCy("billingadmindashboard-title").should("be.visible");
  cy.getCy("billingadmindashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Saving screenshot for BillingAdminDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_admin_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/16 | 12%] - Verified BillingAdminDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Navigating to /staff/receptionist-dashboard (ReceptionistDashboardScreen)...");
  cy.visitWithSemantics("/staff/receptionist-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Checking shell & content for ReceptionistDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistdashboard-screen").should("be.visible");
  cy.getCy("receptionistdashboard-title").should("be.visible");
  cy.getCy("receptionistdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Saving screenshot for ReceptionistDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("receptionist_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [3/16 | 18%] - Verified ReceptionistDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Navigating to /common/office-analytics (OfficeAnalyticsScreen)...");
  cy.visitWithSemantics("/common/office-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Checking shell & content for OfficeAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officeanalytics-screen").should("be.visible");
  cy.getCy("officeanalytics-title").should("be.visible");
  cy.getCy("officeanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Saving screenshot for OfficeAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("office_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [4/16 | 25%] - Verified OfficeAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Navigating to /common/office-compliance (OfficeComplianceScreen)...");
  cy.visitWithSemantics("/common/office-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Checking shell & content for OfficeComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officecompliance-screen").should("be.visible");
  cy.getCy("officecompliance-title").should("be.visible");
  cy.getCy("officecompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Saving screenshot for OfficeComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("office_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [5/16 | 31%] - Verified OfficeComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Navigating to /common/office-workflow (OfficeWorkflowScreen)...");
  cy.visitWithSemantics("/common/office-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Checking shell & content for OfficeWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officeworkflow-screen").should("be.visible");
  cy.getCy("officeworkflow-title").should("be.visible");
  cy.getCy("officeworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Saving screenshot for OfficeWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("office_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [6/16 | 37%] - Verified OfficeWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Navigating to /staff/billing-admin-analytics (BillingAdminAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/billing-admin-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Checking shell & content for BillingAdminAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadminanalytics-screen").should("be.visible");
  cy.getCy("billingadminanalytics-title").should("be.visible");
  cy.getCy("billingadminanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Saving screenshot for BillingAdminAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_admin_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [7/16 | 43%] - Verified BillingAdminAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Navigating to /staff/billing-admin-compliance (BillingAdminComplianceScreen)...");
  cy.visitWithSemantics("/staff/billing-admin-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Checking shell & content for BillingAdminComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadmincompliance-screen").should("be.visible");
  cy.getCy("billingadmincompliance-title").should("be.visible");
  cy.getCy("billingadmincompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Saving screenshot for BillingAdminComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_admin_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [8/16 | 50%] - Verified BillingAdminComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Navigating to /staff/billing-admin-workflow (BillingAdminWorkflowScreen)...");
  cy.visitWithSemantics("/staff/billing-admin-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Checking shell & content for BillingAdminWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadminworkflow-screen").should("be.visible");
  cy.getCy("billingadminworkflow-title").should("be.visible");
  cy.getCy("billingadminworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Saving screenshot for BillingAdminWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_admin_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [9/16 | 56%] - Verified BillingAdminWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Navigating to /staff/receptionist-analytics (ReceptionistAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/receptionist-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Checking shell & content for ReceptionistAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistanalytics-screen").should("be.visible");
  cy.getCy("receptionistanalytics-title").should("be.visible");
  cy.getCy("receptionistanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Saving screenshot for ReceptionistAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("receptionist_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [10/16 | 62%] - Verified ReceptionistAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Navigating to /staff/receptionist-compliance (ReceptionistComplianceScreen)...");
  cy.visitWithSemantics("/staff/receptionist-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Checking shell & content for ReceptionistComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistcompliance-screen").should("be.visible");
  cy.getCy("receptionistcompliance-title").should("be.visible");
  cy.getCy("receptionistcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Saving screenshot for ReceptionistComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("receptionist_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [11/16 | 68%] - Verified ReceptionistComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Navigating to /staff/receptionist-workflow (ReceptionistWorkflowScreen)...");
  cy.visitWithSemantics("/staff/receptionist-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Checking shell & content for ReceptionistWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistworkflow-screen").should("be.visible");
  cy.getCy("receptionistworkflow-title").should("be.visible");
  cy.getCy("receptionistworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Saving screenshot for ReceptionistWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("receptionist_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [12/16 | 75%] - Verified ReceptionistWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Navigating to /staff/invoice-management (InvoiceManagementScreen)...");
  cy.visitWithSemantics("/staff/invoice-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Checking shell & content for InvoiceManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("invoicemanagement-screen").should("be.visible");
  cy.getCy("invoicemanagement-title").should("be.visible");
  cy.getCy("invoicemanagement-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Saving screenshot for InvoiceManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("invoice_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [13/16 | 81%] - Verified InvoiceManagementScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Navigating to /staff/claims-processing (ClaimsProcessingScreen)...");
  cy.visitWithSemantics("/staff/claims-processing");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Checking shell & content for ClaimsProcessingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("claimsprocessing-screen").should("be.visible");
  cy.getCy("claimsprocessing-title").should("be.visible");
  cy.getCy("claimsprocessing-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Saving screenshot for ClaimsProcessingScreen...");
  cy.waitAndSee();
  cy.screenshot("claims_processing");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [14/16 | 87%] - Verified ClaimsProcessingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Navigating to /staff/payment-tracking (PaymentTrackingScreen)...");
  cy.visitWithSemantics("/staff/payment-tracking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Checking shell & content for PaymentTrackingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("paymenttracking-screen").should("be.visible");
  cy.getCy("paymenttracking-title").should("be.visible");
  cy.getCy("paymenttracking-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Saving screenshot for PaymentTrackingScreen...");
  cy.waitAndSee();
  cy.screenshot("payment_tracking");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [15/16 | 93%] - Verified PaymentTrackingScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Navigating to /staff/refund-management (RefundManagementScreen)...");
  cy.visitWithSemantics("/staff/refund-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Checking shell & content for RefundManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("refundmanagement-screen").should("be.visible");
  cy.getCy("refundmanagement-title").should("be.visible");
  cy.getCy("refundmanagement-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Saving screenshot for RefundManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("refund_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [16/16 | 100%] - Verified RefundManagementScreen successfully!\n");

  });
});
