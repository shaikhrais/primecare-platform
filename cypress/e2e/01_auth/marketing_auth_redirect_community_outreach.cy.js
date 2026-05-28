// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = marketing, role = community_outreach

describe("Auth Redirect - community_outreach", () => {
  it("performs dynamic SSO auth and verifies landing on marketing app shell", () => {
    cy.loginAsRole("community_outreach");
  });
});
