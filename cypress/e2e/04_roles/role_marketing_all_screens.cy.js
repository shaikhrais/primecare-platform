// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - marketing", () => {
  it("tests all screens for role marketing", () => {
    cy.loginAsRole("marketing");


  cy.visit("/management/head-of-marketing-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingdashboard-screen").should("be.visible");
  cy.getCy("headofmarketingdashboard-title").should("be.visible");
  cy.getCy("headofmarketingdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_marketing_dashboard");

  cy.visit("/management/local-marketing-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerdashboard-screen").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-title").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_dashboard");

  cy.visit("/management/head-of-marketing-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketinganalytics-screen").should("be.visible");
  cy.getCy("headofmarketinganalytics-title").should("be.visible");
  cy.getCy("headofmarketinganalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_marketing_analytics");

  cy.visit("/management/head-of-marketing-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingcompliance-screen").should("be.visible");
  cy.getCy("headofmarketingcompliance-title").should("be.visible");
  cy.getCy("headofmarketingcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_marketing_compliance");

  cy.visit("/management/head-of-marketing-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingworkflow-screen").should("be.visible");
  cy.getCy("headofmarketingworkflow-title").should("be.visible");
  cy.getCy("headofmarketingworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_marketing_workflow");

  cy.visit("/management/local-marketing-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanageranalytics-screen").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-title").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_analytics");

  cy.visit("/management/local-marketing-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagercompliance-screen").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-title").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_compliance");

  cy.visit("/management/local-marketing-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerworkflow-screen").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-title").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_workflow");

  cy.visit("/management/campaign-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("campaigndashboard-screen").should("be.visible");
  cy.getCy("campaigndashboard-title").should("be.visible");
  cy.getCy("campaigndashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("campaign_dashboard");

  cy.visit("/management/lead-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("leadanalytics-screen").should("be.visible");
  cy.getCy("leadanalytics-title").should("be.visible");
  cy.getCy("leadanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("lead_analytics");

  cy.visit("/management/social-media");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialmedia-screen").should("be.visible");
  cy.getCy("socialmedia-title").should("be.visible");
  cy.getCy("socialmedia-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("social_media");

  cy.visit("/management/brand-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("brandmanagement-screen").should("be.visible");
  cy.getCy("brandmanagement-title").should("be.visible");
  cy.getCy("brandmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("brand_management");

  });
});
