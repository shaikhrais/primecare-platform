// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = client, role = portal

describe("Auth Redirect - portal", () => {
  it("performs dynamic SSO auth and verifies landing on client app shell", () => {
    cy.loginAsRole("portal");
  });
});
