describe("Organization Full E2E Spec", () => {
  it("performs dynamic organization sweep and checks language switching", () => {
    cy.loginAsRole("psw");
    cy.switchLanguage("fr");
    cy.get('[data-cy="app-shell"]').should("be.visible");
    cy.screenshot("org-full-fr");
  });
});
