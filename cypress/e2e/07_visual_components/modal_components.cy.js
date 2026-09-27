describe("Visual Component - Modals", () => {
  it("verifies action modals", () => {
    cy.visitWithSemantics("/#/login");
    cy.loginAsRole("psw");
    cy.verifyNotBlank();
    cy.screenshot("component-action-modal");
  });
});