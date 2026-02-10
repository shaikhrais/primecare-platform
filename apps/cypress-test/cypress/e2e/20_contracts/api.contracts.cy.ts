/// <reference path="../../support/index.d.ts" />

describe("API Contract Verification (UI-less)", { tags: ["@api", "@smoke"] }, () => {

    it("GET /user/profile returns correct identity shape", () => {
        cy.fixture("users.json").then((users) => {
            const u = users.staff;

            // 1. Get token via request (fast)
            cy.request({
                method: "POST",
                url: `${Cypress.env("API_BASE_URL")}/v1/auth/login`,
                body: { email: u.email, password: u.password }
            }).then((resp) => {
                const token = resp.body.token;

                // 2. Verify Profile contract
                cy.request({
                    method: "GET",
                    url: `${Cypress.env("API_BASE_URL")}/v1/user/profile`,
                    headers: { Authorization: `Bearer ${token}` }
                }).then((profileResp) => {
                    expect(profileResp.status).to.eq(200);
                    expect(profileResp.body).to.have.property("email", u.email);
                    expect(profileResp.body).to.have.any.keys("id", "role", "profile");
                });
            });
        });
    });

    it("GET /admin/stats returns expected keys", () => {
        cy.fixture("users.json").then((users) => {
            const u = users.staff;
            cy.request("POST", `${Cypress.env("API_BASE_URL")}/v1/auth/login`, { email: u.email, password: u.password })
                .then((resp) => {
                    cy.request({
                        method: "GET",
                        url: `${Cypress.env("API_BASE_URL")}/v1/admin/stats`,
                        headers: { Authorization: `Bearer ${resp.body.token}` }
                    }).then((statsResp) => {
                        expect(statsResp.status).to.eq(200);
                        // Stats often contain counts
                        expect(statsResp.body).to.have.property("totalUsers");
                    });
                });
        });
    });
});
