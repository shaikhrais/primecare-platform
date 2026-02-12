describe("Auth Debug", () => {
    // Try each password in its own test case to see which one passes the assertion
    const roles = ["admin", "staff"];

    context("Testing password: admin123", () => {
        roles.forEach((role) => {
            it(`should login ${role}.a@primecare.ca with admin123`, () => {
                cy.request({
                    method: "POST",
                    url: "https://primecare-api.itpro-mohammed.workers.dev/v1/auth/login",
                    body: { email: `${role}.a@primecare.ca`, password: "admin123" }
                }).its("status").should("equal", 200);
            });
        });
    });

    context("Testing password: password", () => {
        roles.forEach((role) => {
            it(`should login ${role}.a@primecare.ca with password`, () => {
                cy.request({
                    method: "POST",
                    url: "https://primecare-api.itpro-mohammed.workers.dev/v1/auth/login",
                    body: { email: `${role}.a@primecare.ca`, password: "password" },
                    failOnStatusCode: false
                }).its("status").should("equal", 200);
            });
        });
    });

    context("Testing password: Password123!", () => {
        roles.forEach((role) => {
            it(`should login ${role}.a@primecare.ca with Password123!`, () => {
                cy.request({
                    method: "POST",
                    url: "https://primecare-api.itpro-mohammed.workers.dev/v1/auth/login",
                    body: { email: `${role}.a@primecare.ca`, password: "Password123!" },
                    failOnStatusCode: false
                }).its("status").should("equal", 200);
            });
        });
    });
});
