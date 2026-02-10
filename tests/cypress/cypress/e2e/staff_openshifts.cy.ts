/// <reference types="cypress" />

describe('Staff Open Shift Creation', () => {
    const staffEmail = 'staff.test@primecare.com'; // Assumes this user exists from seed/setup
    const staffPassword = 'Password123!';
    let staffToken;
    let clientId;
    let serviceId;

    before(() => {
        // 0. Register a fresh Client to ensure at least one exists with a Profile
        const uniqueClientEmail = `client_${Date.now()}@test.com`;
        cy.request({
            method: 'POST',
            url: `http://localhost:8787/v1/auth/register`,
            body: { email: uniqueClientEmail, password: 'Password123!', role: 'client' },
            failOnStatusCode: false // If it somehow exists, fine
        }).then(() => {
            // 1. Login as Staff to get Token
            cy.request({
                method: 'POST',
                url: `http://localhost:8787/v1/auth/login`,
                body: { email: staffEmail, password: staffPassword }
            }).then((resp) => {
                expect(resp.status).to.eq(200);
                staffToken = resp.body.token;

                // 2. Get a Client ID
                cy.request({
                    method: 'GET',
                    url: `http://localhost:8787/v1/staff/customers`,
                    headers: { Authorization: `Bearer ${staffToken}` }
                }).then((clientResp) => {
                    expect(clientResp.status).to.eq(200);
                    // Find our specific client logic if needed, or just take the first one
                    // We expect at least the one we just created
                    expect(clientResp.body.length).to.be.gt(0);
                    clientId = clientResp.body.find((c: any) => c.user?.email === uniqueClientEmail)?.id || clientResp.body[0].id;
                });

                // 3. Get a Service ID (from Public endpoint)
                cy.request({
                    method: 'GET',
                    url: `http://localhost:8787/v1/public/services`,
                }).then((serviceResp) => {
                    expect(serviceResp.status).to.eq(200);
                    expect(serviceResp.body.length).to.be.gt(0);
                    serviceId = serviceResp.body[0].id;
                });
            });
        });
    });
});

it('Creates 5 Open Shifts in a loop', () => {
    // Ensure we have prereqs
    expect(staffToken).to.be.ok;
    expect(clientId).to.be.ok;
    expect(serviceId).to.be.ok;

    // Create 5 shifts
    for (let i = 0; i < 5; i++) {
        // Future date: Tomorrow + i days
        const date = new Date();
        date.setDate(date.getDate() + 1 + i);
        date.setHours(9, 0, 0, 0); // 9 AM

        cy.request({
            method: 'POST',
            url: `http://localhost:8787/v1/staff/visits`,
            headers: { Authorization: `Bearer ${staffToken}` },
            body: {
                clientId: clientId,
                serviceId: serviceId,
                requestedStartAt: date.toISOString(),
                durationMinutes: 60,
                notes: `Cypress Auto-Gen Shift #${i + 1}`
            }
        }).then((resp) => {
            expect(resp.status).to.eq(201);
            expect(resp.body.status).to.eq('requested');
            expect(resp.body.clientId).to.eq(clientId);
        });
    }
});
});
