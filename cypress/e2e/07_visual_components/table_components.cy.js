describe("Visual Component - Tables", () => {
  it("verifies standard data tables", () => {
    cy.visitWithSemantics("/#/login");
    cy.loginAsRole("psw");
    cy.verifyNotBlank();
    cy.screenshot("component-data-table");
  });
});