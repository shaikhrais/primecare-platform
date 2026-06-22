// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = corporate, role = volunteer_coordinator

describe("Auth Redirect - volunteer_coordinator", () => {
  it("performs dynamic SSO auth and verifies landing on corporate app shell", () => {
    cy.loginAsRole("volunteer_coordinator");
  });
});
