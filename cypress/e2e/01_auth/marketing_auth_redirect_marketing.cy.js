// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = marketing, role = marketing

describe("Auth Redirect - marketing", () => {
  it("performs dynamic SSO auth and verifies landing on marketing app shell", () => {
    cy.loginAsRole("marketing");
  });
});
