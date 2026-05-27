describe("Visual Component - Shell", () => {
  it("shows app shell components", () => {
    cy.visit("/#/login?enable-semantics=true");
    cy.wait(2000);

    cy.get("body").should("be.visible");

    cy.loginAsRole("psw");

    cy.getCy("app-shell").should("be.visible");
    cy.getCy("app-topbar").should("be.visible");
    cy.getCy("app-sidebar").should("be.visible");
    cy.getCy("app-content-slot").should("be.visible");

    cy.screenshot("component-app-shell");
  });
});
