import { CLINICAL_ACCESS_CASES } from '../../support/access/access-matrix';

describe("API RBAC Access Matrix", { tags: ["@security", "@rbac"] }, () => {
    const roles = ["admin", "manager", "staff", "rn", "psw", "client"];

    roles.forEach((role) => {
        describe(`Role: ${role}`, () => {
            beforeEach(() => {
                // Assuming we have a way to set the auth cookie directly or login
                // For direct API tests, we might want to use cy.request login
                cy.request({
                    method: 'POST',
                    url: `${Cypress.env('API_URL')}/v1/auth/login`,
                    body: {
                        email: `${role}.prime@primecare.ca`, // Simplified for demo
                        password: 'Password123!'
                    }
                });
            });

            CLINICAL_ACCESS_CASES.forEach((testCase) => {
                const isAllowed = testCase.allowedRoles.includes(role);

                it(`${isAllowed ? 'ALLOWS' : 'DENIES'} ${testCase.method} ${testCase.url}`, () => {
                    cy.request({
                        method: testCase.method,
                        url: `${Cypress.env('API_URL')}${testCase.url}`,
                        body: testCase.body,
                        failOnStatusCode: false
                    }).then((response) => {
                        if (isAllowed) {
                            expect(response.status).to.be.oneOf([200, 201]);
                        } else {
                            expect(response.status).to.equal(403);
                        }
                    });
                });
            });
        });
    });
});
