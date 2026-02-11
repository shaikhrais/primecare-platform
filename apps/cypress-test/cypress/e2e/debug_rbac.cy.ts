
describe("Manual RBAC Check", () => {
    it("checks redirect for guest on admin dashboard", () => {
        cy.logout();
        cy.visit("https://primecare-admin.pages.dev/dashboard", { failOnStatusCode: false });
        cy.url().should("include", "/login");
    });

    it("checks redirect for logged in user on login page", () => {
        cy.loginAs("client");
        cy.visit("https://primecare-admin.pages.dev/login", { failOnStatusCode: false });
        cy.url().should("not.include", "/login");
    });
});
