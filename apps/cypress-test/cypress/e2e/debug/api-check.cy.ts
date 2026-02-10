
describe("API Connectivity Check", () => {
    it("can reach the API root", () => {
        // Try to reach API directly - using 127.0.0.1 just in case
        cy.request({
            url: "http://127.0.0.1:8787/health",
            failOnStatusCode: false
        }).then((response) => {
            cy.log(`API Response: ${response.status}`);
        });
    });

    it("verifies VITE_API_URL usage in app", () => {
        cy.on("window:console", (msg) => {
            cy.log(`BROWSER CONSOLE: ${JSON.stringify(msg)}`);
        });

        // EXPLICIT IP
        cy.visit("http://127.0.0.1:5173/login");

        cy.get('[data-cy="inp-email"]').should('be.visible').type("test@test.com");
        cy.get('[data-cy="inp-password"]').type("password");
        cy.get('[data-cy="btn-login"]').click();

        cy.wait(2000);
    });
});
