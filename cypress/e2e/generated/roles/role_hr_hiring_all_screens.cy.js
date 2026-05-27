// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.


function login() {
  cy.visit("/login");
  cy.wait(2000);

  cy.get('[data-cy="login-email"]').should("be.visible").clear().type("qa.hr_hiring@test.primecare.local");
  cy.get('[data-cy="login-password"]').should("be.visible").clear().type(Cypress.env("TEST_PASSWORD"), { log: false });
  cy.get('[data-cy="login-submit"]').should("be.visible").click();

  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");
}

describe("Role All Screens - hr_hiring", () => {
  it("tests all screens for role hr_hiring", () => {
    login();


  cy.visit("/staff/hr-hiring-dashboard");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringdashboard-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringdashboard-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringdashboard-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_dashboard");

  cy.visit("/staff/hr-hiring-analytics");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringanalytics-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringanalytics-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringanalytics-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_analytics");

  cy.visit("/staff/hr-hiring-compliance");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringcompliance-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringcompliance-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringcompliance-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_compliance");

  cy.visit("/staff/hr-hiring-workflow");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringworkflow-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringworkflow-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringworkflow-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_workflow");

  cy.visit("/staff/hr-hiring-applicants");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringapplicants-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringapplicants-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringapplicants-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_applicants");

  cy.visit("/staff/hr-hiring-interviews");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringinterviews-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringinterviews-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringinterviews-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_interviews");

  cy.visit("/staff/hr-hiring-offers");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringoffers-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringoffers-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringoffers-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_offers");

  cy.visit("/staff/hr-hiring-onboarding");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringonboarding-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringonboarding-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringonboarding-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_onboarding");

  cy.visit("/staff/hr-hiring-credentials");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="hrhiringcredentials-screen"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringcredentials-title"]`).should("be.visible");
  cy.get(`[data-cy="hrhiringcredentials-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("hr_hiring_credentials");

  cy.visit("/staff/applicant-tracking");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="applicanttracking-screen"]`).should("be.visible");
  cy.get(`[data-cy="applicanttracking-title"]`).should("be.visible");
  cy.get(`[data-cy="applicanttracking-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("applicant_tracking");

  cy.visit("/staff/interview-scheduling");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="interviewscheduling-screen"]`).should("be.visible");
  cy.get(`[data-cy="interviewscheduling-title"]`).should("be.visible");
  cy.get(`[data-cy="interviewscheduling-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("interview_scheduling");

  cy.visit("/staff/offer-management");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="offermanagement-screen"]`).should("be.visible");
  cy.get(`[data-cy="offermanagement-title"]`).should("be.visible");
  cy.get(`[data-cy="offermanagement-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("offer_management");

  cy.visit("/staff/onboarding-checklist");
  cy.wait(2000);

  cy.get('[data-cy="app-shell"]').should("be.visible");
  cy.get('[data-cy="app-topbar"]').should("be.visible");
  cy.get('[data-cy="app-sidebar"]').should("be.visible");
  cy.get('[data-cy="app-content-slot"]').should("be.visible");

  cy.get("body").invoke("text").should((text) => {
    expect(text.trim().length).to.be.greaterThan(5);
  });

  cy.get(`[data-cy="onboardingchecklist-screen"]`).should("be.visible");
  cy.get(`[data-cy="onboardingchecklist-title"]`).should("be.visible");
  cy.get(`[data-cy="onboardingchecklist-content"]`).should("be.visible");

  cy.wait(2000);
  cy.screenshot("onboarding_checklist");

  });
});
