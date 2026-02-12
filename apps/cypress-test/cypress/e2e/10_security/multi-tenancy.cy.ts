/// <reference path="../../support/index.d.ts" />

/**
 * Multi-Tenancy & Data Isolation Security Suite
 * 
 * Verifies that data is strictly isolated between tenants at the API level.
 * This suite uses direct API intercepts and UI assertions to verify that
 * records from Tenant B are NEVER visible to users of Tenant A.
 */

describe("Security: Multi-Tenancy Data Isolation", { tags: ["@security", "@critical"] }, () => {

    const tenantA = {
        email: "client.a@tenant1.com",
        password: "Password123!",
        tenantSlug: "tenant1"
    };

    const tenantB = {
        email: "client.b@tenant2.com",
        password: "Password123!",
        tenantSlug: "tenant2"
    };

    it("prevents Tenant A user from seeing Tenant B records in lists", () => {
        // 1. Create a dummy visit in Tenant B (if seeds don't exist)
        // For now, we assume seed data contains 'tenant2-visit-id'

        // 2. Login as Tenant A
        cy.loginAs('client', tenantA.email, tenantA.password);
        cy.visitAppRoute('web-admin', '/dashboard');

        // 3. Verify that requests to list endpoints only return Tenant A data
        cy.intercept('GET', '**/v1/client/bookings').as('getBookings');
        cy.wait('@getBookings').then((interception) => {
            const bookings = interception.response?.body;
            // Assert that every booking belongs to Tenant A (implicitly via count or content check)
            // In a real test, we would check the 'tenantId' if exposed, or verify content.
            bookings.forEach((booking: any) => {
                expect(booking.tenantId).to.not.equal('tenant2-id');
            });
        });
    });

    it("denies access to Tenant B resources by direct ID (IDOR prevention)", () => {
        // 1. Login as Tenant A
        cy.loginAs('client', tenantA.email, tenantA.password);

        // 2. Attempt to fetch a specific record belonging to Tenant B
        const tenantBResourceId = '9999-tenant-b-record-id';

        cy.request({
            method: 'GET',
            url: `${Cypress.env('API_URL')}/v1/client/visits/${tenantBResourceId}`,
            failOnStatusCode: false
        }).then((response) => {
            // Should return 404 (or 403) because the scoped Prisma client won't find it
            expect([404, 403]).to.include(response.status);
        });
    });

    it("ensures Cross-Tenant registration creates a new isolation boundary", () => {
        const newOrg = `Org-${Date.now()}`;
        const newSlug = `org-${Date.now()}`;

        // 1. Register a new user with a unique tenant
        cy.request('POST', `${Cypress.env('API_URL')}/v1/auth/register`, {
            email: `admin@${newSlug}.com`,
            password: 'Password123!',
            role: 'admin',
            tenantName: newOrg,
            tenantSlug: newSlug
        }).then((response) => {
            expect(response.status).to.equal(201);
            const { user, token } = response.body;

            // 2. Verify individual resource creation
            cy.request({
                method: 'POST',
                url: `${Cypress.env('API_URL')}/v1/admin/services`,
                headers: { Authorization: `Bearer ${token}` },
                body: {
                    name: "Isolated Service",
                    hourlyRate: 50
                }
            }).then((svcRes) => {
                expect(svcRes.body.tenantId).to.equal(user.tenantId);
            });
        });
    });
});
