import { CLINICAL_ACCESS_CASES } from '../../support/access/access-matrix';

describe("Enterprise RBAC Auto-Verification", { tags: ["@security", "@rbac"] }, () => {
    const roles = ["admin", "manager", "staff", "rn", "psw", "client"];

    roles.forEach((role) => {
        describe(`Role: ${role}`, () => {
            beforeEach(() => {
                // Login via API to get cookie session
                cy.request({
                    method: 'POST',
                    url: `${Cypress.env('API_URL')}/v1/auth/login`,
                    body: {
                        email: `${role}.a@primecare.ca`,
                        password: 'admin123'
                    }
                }).then((resp) => {
                    expect(resp.status).to.eq(200);
                });
            });

            CLINICAL_ACCESS_CASES.forEach((testCase) => {
                const isAllowed = testCase.allowedRoles.includes(role);

                it(`${isAllowed ? '✅ SHOULD ALLOW' : '❌ SHOULD DENY'} ${testCase.name} (${testCase.method} ${testCase.url})`, () => {
                    cy.request({
                        method: testCase.method,
                        url: `${Cypress.env('API_URL')}${testCase.url}`,
                        body: testCase.body,
                        failOnStatusCode: false
                    }).then((response) => {
                        if (isAllowed) {
                            // Being allowed might return 200/201, or 404 if the demo ID doesn't exist, 
                            // but NOT 403 Forbidden which is what we are testing here.
                            expect(response.status).to.not.equal(403, `Access should be GRANTED for ${role}`);
                        } else {
                            expect(response.status).to.equal(403, `Access should be DENIED for ${role}`);
                        }
                    });
                });
            });
        });
    });
});
