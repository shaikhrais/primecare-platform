type Role = "guest" | "client" | "psw" | "manager" | "staff";

export { };

declare global {
    namespace Cypress {
        interface Chainable {
            loginAs(role: Role): Chainable<void>;
            logout(): Chainable<void>;
        }
    }
}

Cypress.Commands.add("loginAs", (role: Role) => {
    if (role === "guest") {
        cy.log("Continuing as guest (skipping login)");
        return;
    }

    cy.fixture("users.json").then((users) => {
        const u = users[role];
        if (!u) throw new Error(`Missing credentials for role: ${role}`);

        const apiUrl = Cypress.env("API_BASE_URL");
        cy.log(`API Login for ${role} at ${apiUrl}`);

        // Zero-UI Login for speed and stability
        cy.request({
            method: "POST",
            url: `${apiUrl}/v1/auth/login`,
            body: {
                email: u.email,
                password: u.password
            },
            failOnStatusCode: false
        }).then((res) => {
            if (res.status !== 200) {
                throw new Error(`Login failed for ${role}: ${JSON.stringify(res.body)}`);
            }

            expect(res.body).to.have.property("token");
            expect(res.body).to.have.property("user");

            // Persist to localStorage as the app expects
            window.localStorage.setItem("token", res.body.token);
            window.localStorage.setItem("user", JSON.stringify(res.body.user));

            cy.log(`Authenticated as ${role} via API`);
        });
    });
});

Cypress.Commands.add("logout", () => {
    cy.clearCookies();
    cy.clearLocalStorage();
    cy.log("Session cleared");
});
