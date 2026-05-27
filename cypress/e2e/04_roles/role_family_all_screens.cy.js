// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - family", () => {
  it("tests all screens for role family", () => {
    cy.loginAsRole("family");


  cy.visit("/common/family-member-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberanalytics-screen").should("be.visible");
  cy.getCy("familymemberanalytics-title").should("be.visible");
  cy.getCy("familymemberanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("family_member_analytics");

  cy.visit("/common/family-member-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymembercompliance-screen").should("be.visible");
  cy.getCy("familymembercompliance-title").should("be.visible");
  cy.getCy("familymembercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("family_member_compliance");

  cy.visit("/common/family-member-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familymemberworkflow-screen").should("be.visible");
  cy.getCy("familymemberworkflow-title").should("be.visible");
  cy.getCy("familymemberworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("family_member_workflow");

  cy.visit("/common/family-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("familyoverview-screen").should("be.visible");
  cy.getCy("familyoverview-title").should("be.visible");
  cy.getCy("familyoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("family_overview");

  cy.visit("/common/care-updates");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("careupdates-screen").should("be.visible");
  cy.getCy("careupdates-title").should("be.visible");
  cy.getCy("careupdates-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("care_updates");

  cy.visit("/common/billing-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingoverview-screen").should("be.visible");
  cy.getCy("billingoverview-title").should("be.visible");
  cy.getCy("billingoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing_overview");

  cy.visit("/common/emergency-contacts");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("emergencycontacts-screen").should("be.visible");
  cy.getCy("emergencycontacts-title").should("be.visible");
  cy.getCy("emergencycontacts-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("emergency_contacts");

  });
});
