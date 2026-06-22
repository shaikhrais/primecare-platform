// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = marketing, role = local_marketing

describe("Auth Redirect - local_marketing", () => {
  it("performs dynamic SSO auth and verifies landing on marketing app shell", () => {
    cy.loginAsRole("local_marketing");
  });
});
