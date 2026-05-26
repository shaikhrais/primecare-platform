describe("One App All Roles E2E Spec", () => {
  it("logs in as PSW and verifies app elements", () => {
    cy.loginAsRole("psw");
    cy.get('[data-cy="app-shell"]').should("be.visible");
    cy.screenshot("app-all-roles-psw");
  });
});
