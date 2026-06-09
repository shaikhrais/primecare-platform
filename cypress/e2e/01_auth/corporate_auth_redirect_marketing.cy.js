// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = corporate, role = marketing

describe("Auth Redirect - marketing", () => {
  it("performs dynamic SSO auth and verifies landing on corporate app shell", () => {
    cy.loginAsRole("marketing");
  });
});
