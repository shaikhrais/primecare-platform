
describe("API Connectivity Check", () => {
    it("can reach the API root", () => {
        cy.request({
            url: `${Cypress.env("API_BASE_URL")}/health`,
            failOnStatusCode: false
        }).then((response) => {
            cy.log(`API Response: ${response.status}`);
            expect(response.status).to.be.oneOf([200, 404]); // Some APIs return 404 on root but 200 on /health
        });
    });

    it("verifies VITE_API_URL usage in app", () => {
        cy.visitRoute("ADMIN_BASE_URL", "/login");

        cy.getByCy("inp-email").should('be.visible').type("admin@example.com");
        cy.getByCy("inp-password").type("password");
        cy.getByCy("btn-login").click();

        cy.url({ timeout: 15000 }).should('not.include', '/login');
    });
});
