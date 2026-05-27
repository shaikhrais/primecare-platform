// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.admin@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - admin", () => {
  it("tests all screens for role admin", () => {
    login();


  cy.visit("/common/office-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="officedashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="officedashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="officedashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("office_dashboard");

  cy.visit("/staff/billing-admin-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="billingadmindashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="billingadmindashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="billingadmindashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("billing_admin_dashboard");

  cy.visit("/staff/receptionist-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="receptionistdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="receptionistdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="receptionistdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("receptionist_dashboard");

  cy.visit("/common/office-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="officeanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="officeanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="officeanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("office_analytics");

  cy.visit("/common/office-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="officecompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="officecompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="officecompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("office_compliance");

  cy.visit("/common/office-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="officeworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="officeworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="officeworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("office_workflow");

  cy.visit("/staff/billing-admin-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="billingadminanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="billingadminanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="billingadminanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("billing_admin_analytics");

  cy.visit("/staff/billing-admin-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="billingadmincompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="billingadmincompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="billingadmincompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("billing_admin_compliance");

  cy.visit("/staff/billing-admin-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="billingadminworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="billingadminworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="billingadminworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("billing_admin_workflow");

  cy.visit("/staff/receptionist-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="receptionistanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="receptionistanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="receptionistanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("receptionist_analytics");

  cy.visit("/staff/receptionist-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="receptionistcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="receptionistcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="receptionistcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("receptionist_compliance");

  cy.visit("/staff/receptionist-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="receptionistworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="receptionistworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="receptionistworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("receptionist_workflow");

  cy.visit("/staff/invoice-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="invoicemanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="invoicemanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="invoicemanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("invoice_management");

  cy.visit("/staff/claims-processing");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="claimsprocessing-screen"]`).should("be.visible");
  cy.get(`[data-cy="claimsprocessing-title"]`).should("be.visible");
  cy.get(`[data-cy="claimsprocessing-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("claims_processing");

  cy.visit("/staff/payment-tracking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="paymenttracking-screen"]`).should("be.visible");
  cy.get(`[data-cy="paymenttracking-title"]`).should("be.visible");
  cy.get(`[data-cy="paymenttracking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("payment_tracking");

  cy.visit("/staff/refund-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="refundmanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="refundmanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="refundmanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("refund_management");

  });
});
