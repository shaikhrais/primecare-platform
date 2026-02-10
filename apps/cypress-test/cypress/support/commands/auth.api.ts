export { };

declare global {
    namespace Cypress {
        interface Chainable {
            loginAsAdminAPI(): Chainable<void>;
            loginAsManagerAPI(): Chainable<void>;
        }
    }
}

Cypress.Commands.add("loginAsAdminAPI", () => {
    cy.step("Login as Admin (API)");
    cy.request({
        method: "POST",
        url: `${Cypress.env("API_URL")}/auth/login`,
        body: {
            email: Cypress.env("ADMIN_EMAIL") || "admin@example.com",
            password: Cypress.env("ADMIN_PASSWORD") || "password",
        },
    }).then((resp) => {
        window.localStorage.setItem("token", resp.body.token);
        window.localStorage.setItem("user", JSON.stringify(resp.body.user));
    });
});

Cypress.Commands.add("loginAsManagerAPI", () => {
    cy.step("Login as Manager (API)");
    cy.request({
        method: "POST",
        url: `${Cypress.env("API_URL")}/auth/login`,
        body: {
            email: Cypress.env("MANAGER_EMAIL") || "manager@example.com",
            password: Cypress.env("MANAGER_PASSWORD") || "password",
        },
    }).then((resp) => {
        window.localStorage.setItem("token", resp.body.token);
        window.localStorage.setItem("user", JSON.stringify(resp.body.user));
    });
});
