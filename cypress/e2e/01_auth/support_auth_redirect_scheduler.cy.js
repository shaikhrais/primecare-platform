// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = support, role = scheduler

describe("Auth Redirect - scheduler", () => {
  it("performs dynamic SSO auth and verifies landing on support app shell", () => {
    cy.loginAsRole("scheduler");
  });
});
