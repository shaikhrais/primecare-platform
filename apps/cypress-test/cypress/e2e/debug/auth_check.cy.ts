describe("Auth Debug", () => {
    const roles = ["admin", "staff"];
    const passwords = ["Password123!", "admin", "12345678"];

    passwords.forEach((password) => {
        context(`Testing password: ${password}`, () => {
            roles.forEach((role) => {
                it(`should login ${role}.a@primecare.ca with ${password}`, () => {
                    cy.request({
                        method: "POST",
                        url: "https://primecare-api.itpro-mohammed.workers.dev/v1/auth/login",
                        body: { email: `${role}.a@primecare.ca`, password },
                        failOnStatusCode: false
                    }).its("status").should("equal", 200);
                });
            });
        });
    });
});
