// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = franchise, role = franchise_sales

describe("Auth Redirect - franchise_sales", () => {
  it("performs dynamic SSO auth and verifies landing on franchise app shell", () => {
    cy.loginAsRole("franchise_sales");
  });
});
