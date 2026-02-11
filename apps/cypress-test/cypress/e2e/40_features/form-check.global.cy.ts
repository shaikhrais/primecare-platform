/// <reference path="../../support/index.d.ts" />

/**
 * Enterprise Global Form Audit
 * This suite verifies the 6-layer verification strategy across multiple entry points.
 * Standardized data-cy pattern: form.<entity>.<field>
 * Standardized guard pattern: guard.unsaved.dialog
 */

const byCy = (v: string) => `[data-cy="${v}"]`;

const auditedForms = [
    {
        name: "Profile Update",
        route: "/profile",
        role: "staff",
        container: "form.profile.page",
        dirtyField: "form.profile.fullname",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Daily Care Entry",
        route: "/manager/daily-entry",
        role: "manager",
        container: "form.daily.page",
        dirtyField: "form.daily.notes",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Service Configuration",
        route: "/services",
        role: "staff",
        container: "form.service.page",
        triggerModal: "btn.service.add",
        modalContainer: "modal.service.container",
        dirtyField: "modal.service.name",
        closeAction: "modal.service.close",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Client Admission",
        route: "/admin/clients/admission",
        role: "staff",
        container: "form.client.page",
        dirtyField: "form.client.fullname",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    }
];

describe("Global Enterprise Form Audit", { tags: ["@enterprise", "@smoke", "@forms"] }, () => {

    auditedForms.forEach((form) => {
        describe(`Form Audit: ${form.name}`, () => {

            beforeEach(() => {
                cy.clearCookies();
                cy.clearLocalStorage();
                cy.loginAs(form.role as any);
                cy.visit(`${Cypress.env("ADMIN_BASE_URL")}${form.route}`, { failOnStatusCode: false });
                if (form.triggerModal) {
                    cy.get(byCy(form.triggerModal)).click();
                }
            });

            it(`Layer 1 & 2: Structural & Contract Integrity`, () => {
                const target = form.modalContainer || form.container;
                cy.get(byCy(target)).should("be.visible");
            });

            it(`Layer 6: Unsaved Changes Guard Verification`, () => {
                // 1. Make the form dirty
                cy.get(byCy(form.dirtyField)).type("Enterprise Test Change");

                // 2. Attempt to leave/close
                if (form.closeAction) {
                    cy.get(byCy(form.closeAction)).click();
                } else {
                    // Navigate away via browser-like behavior (going back or clicking another link is harder in Cy, so we use the page's own back mechanism if available or use cy.visit to another page)
                    cy.visit(`${Cypress.env("ADMIN_BASE_URL")}/dashboard`, { failOnStatusCode: false });
                }

                // 3. Verify Guard Dialog
                cy.get(byCy("guard.unsaved.dialog")).should("be.visible");

                // 4. Verify "Stay" behavior
                cy.get(byCy(form.stayAction)).click();
                cy.get(byCy("guard.unsaved.dialog")).should("not.exist");
                const target = form.modalContainer || form.container;
                cy.get(byCy(target)).should("be.visible");

                // 5. Verify "Leave" behavior
                if (form.closeAction) {
                    cy.get(byCy(form.closeAction)).click();
                } else {
                    cy.visit(`${Cypress.env("ADMIN_BASE_URL")}/dashboard`, { failOnStatusCode: false });
                }
                cy.get(byCy(form.leaveAction)).click({ force: true });
                cy.url().should("not.include", form.route);
            });
        });
    });
});
