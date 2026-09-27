describe("Visual Component - Language Switcher", () => {
  it("verifies language switcher visibility", () => {
    cy.visitWithSemantics("/#/login");
    cy.loginAsRole("psw");
    cy.getCy("topbar-language-switcher").should("be.visible");
    cy.screenshot("component-language-switcher");
  });
});