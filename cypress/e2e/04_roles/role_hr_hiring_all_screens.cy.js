// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - hr_hiring", () => {
  it("tests all screens for role hr_hiring", () => {
    cy.loginAsRole("hr_hiring");


  cy.visit("/staff/hr-hiring-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringdashboard-screen").should("be.visible");
  cy.getCy("hrhiringdashboard-title").should("be.visible");
  cy.getCy("hrhiringdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_dashboard");

  cy.visit("/staff/hr-hiring-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringanalytics-screen").should("be.visible");
  cy.getCy("hrhiringanalytics-title").should("be.visible");
  cy.getCy("hrhiringanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_analytics");

  cy.visit("/staff/hr-hiring-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringcompliance-screen").should("be.visible");
  cy.getCy("hrhiringcompliance-title").should("be.visible");
  cy.getCy("hrhiringcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_compliance");

  cy.visit("/staff/hr-hiring-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringworkflow-screen").should("be.visible");
  cy.getCy("hrhiringworkflow-title").should("be.visible");
  cy.getCy("hrhiringworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_workflow");

  cy.visit("/staff/hr-hiring-applicants");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringapplicants-screen").should("be.visible");
  cy.getCy("hrhiringapplicants-title").should("be.visible");
  cy.getCy("hrhiringapplicants-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_applicants");

  cy.visit("/staff/hr-hiring-interviews");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringinterviews-screen").should("be.visible");
  cy.getCy("hrhiringinterviews-title").should("be.visible");
  cy.getCy("hrhiringinterviews-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_interviews");

  cy.visit("/staff/hr-hiring-offers");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringoffers-screen").should("be.visible");
  cy.getCy("hrhiringoffers-title").should("be.visible");
  cy.getCy("hrhiringoffers-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_offers");

  cy.visit("/staff/hr-hiring-onboarding");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringonboarding-screen").should("be.visible");
  cy.getCy("hrhiringonboarding-title").should("be.visible");
  cy.getCy("hrhiringonboarding-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_onboarding");

  cy.visit("/staff/hr-hiring-credentials");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringcredentials-screen").should("be.visible");
  cy.getCy("hrhiringcredentials-title").should("be.visible");
  cy.getCy("hrhiringcredentials-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_credentials");

  cy.visit("/staff/applicant-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("applicanttracking-screen").should("be.visible");
  cy.getCy("applicanttracking-title").should("be.visible");
  cy.getCy("applicanttracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("applicant_tracking");

  cy.visit("/staff/interview-scheduling");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("interviewscheduling-screen").should("be.visible");
  cy.getCy("interviewscheduling-title").should("be.visible");
  cy.getCy("interviewscheduling-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("interview_scheduling");

  cy.visit("/staff/offer-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("offermanagement-screen").should("be.visible");
  cy.getCy("offermanagement-title").should("be.visible");
  cy.getCy("offermanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("offer_management");

  cy.visit("/staff/onboarding-checklist");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("onboardingchecklist-screen").should("be.visible");
  cy.getCy("onboardingchecklist-title").should("be.visible");
  cy.getCy("onboardingchecklist-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("onboarding_checklist");

  });
});
