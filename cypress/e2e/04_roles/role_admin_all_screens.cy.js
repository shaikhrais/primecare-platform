// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - admin", () => {
  it("tests all screens for role admin", () => {
    cy.loginAsRole("admin");


  cy.visit("/common/office-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officedashboard-screen").should("be.visible");
  cy.getCy("officedashboard-title").should("be.visible");
  cy.getCy("officedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("office_dashboard");

  cy.visit("/staff/billing-admin-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadmindashboard-screen").should("be.visible");
  cy.getCy("billingadmindashboard-title").should("be.visible");
  cy.getCy("billingadmindashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing_admin_dashboard");

  cy.visit("/staff/receptionist-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistdashboard-screen").should("be.visible");
  cy.getCy("receptionistdashboard-title").should("be.visible");
  cy.getCy("receptionistdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("receptionist_dashboard");

  cy.visit("/common/office-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officeanalytics-screen").should("be.visible");
  cy.getCy("officeanalytics-title").should("be.visible");
  cy.getCy("officeanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("office_analytics");

  cy.visit("/common/office-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officecompliance-screen").should("be.visible");
  cy.getCy("officecompliance-title").should("be.visible");
  cy.getCy("officecompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("office_compliance");

  cy.visit("/common/office-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officeworkflow-screen").should("be.visible");
  cy.getCy("officeworkflow-title").should("be.visible");
  cy.getCy("officeworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("office_workflow");

  cy.visit("/staff/billing-admin-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadminanalytics-screen").should("be.visible");
  cy.getCy("billingadminanalytics-title").should("be.visible");
  cy.getCy("billingadminanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing_admin_analytics");

  cy.visit("/staff/billing-admin-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadmincompliance-screen").should("be.visible");
  cy.getCy("billingadmincompliance-title").should("be.visible");
  cy.getCy("billingadmincompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing_admin_compliance");

  cy.visit("/staff/billing-admin-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadminworkflow-screen").should("be.visible");
  cy.getCy("billingadminworkflow-title").should("be.visible");
  cy.getCy("billingadminworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing_admin_workflow");

  cy.visit("/staff/receptionist-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistanalytics-screen").should("be.visible");
  cy.getCy("receptionistanalytics-title").should("be.visible");
  cy.getCy("receptionistanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("receptionist_analytics");

  cy.visit("/staff/receptionist-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistcompliance-screen").should("be.visible");
  cy.getCy("receptionistcompliance-title").should("be.visible");
  cy.getCy("receptionistcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("receptionist_compliance");

  cy.visit("/staff/receptionist-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistworkflow-screen").should("be.visible");
  cy.getCy("receptionistworkflow-title").should("be.visible");
  cy.getCy("receptionistworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("receptionist_workflow");

  cy.visit("/staff/invoice-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("invoicemanagement-screen").should("be.visible");
  cy.getCy("invoicemanagement-title").should("be.visible");
  cy.getCy("invoicemanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("invoice_management");

  cy.visit("/staff/claims-processing");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("claimsprocessing-screen").should("be.visible");
  cy.getCy("claimsprocessing-title").should("be.visible");
  cy.getCy("claimsprocessing-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("claims_processing");

  cy.visit("/staff/payment-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("paymenttracking-screen").should("be.visible");
  cy.getCy("paymenttracking-title").should("be.visible");
  cy.getCy("paymenttracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("payment_tracking");

  cy.visit("/staff/refund-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("refundmanagement-screen").should("be.visible");
  cy.getCy("refundmanagement-title").should("be.visible");
  cy.getCy("refundmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("refund_management");

  });
});
