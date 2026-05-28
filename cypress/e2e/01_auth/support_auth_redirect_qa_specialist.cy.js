// AUTO-GENERATED ROLE-APP REDIRECT SPEC. DO NOT EDIT.
// Generated from SQLite governance database.
// Dynamic targets: app = support, role = qa_specialist

describe("Auth Redirect - qa_specialist", () => {
  it("performs dynamic SSO auth and verifies landing on support app shell", () => {
    cy.loginAsRole("qa_specialist");
  });
});
