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
    },
    {
        name: "Staff Evaluation",
        route: "/manager/evaluations",
        role: "manager",
        container: "form.evaluation.page",
        dirtyField: "form.evaluation.staff",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Service Review",
        route: "/manager/service-review",
        role: "manager",
        container: "form.serviceReview.page",
        dirtyField: "form.serviceReview.client",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Expense Report",
        route: "/psw/expenses",
        role: "psw",
        container: "form.expense.page",
        dirtyField: "form.expense.amount",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Availability Update",
        route: "/psw/availability",
        role: "psw",
        container: "form.availability.page",
        dirtyField: "form.availability.hours",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Client Feedback",
        route: "/client/feedback",
        role: "client",
        container: "form.feedback.page",
        dirtyField: "form.feedback.visit",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Visit Completion",
        route: "/visits/v-123/complete",
        role: "psw",
        container: "form.visitComplete.page",
        dirtyField: "form.visitComplete.signature",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Booking Request",
        route: "/client/bookings/request",
        role: "client",
        container: "form.booking.page",
        dirtyField: "form.booking.date",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Support Ticket",
        route: "/support/tickets/new",
        role: "staff",
        container: "form.supportTicket.page",
        dirtyField: "form.supportTicket.subject",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Location Mgmt",
        route: "/admin/locations/new",
        role: "staff",
        container: "form.location.page",
        dirtyField: "form.location.name",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Billing Portal",
        route: "/client/billing",
        role: "client",
        container: "form.billing.page",
        dirtyField: "", // List view, no dirty guard needed for now
        leaveAction: "",
        stayAction: ""
    },
    {
        name: "User Entry",
        route: "/users/new",
        role: "staff",
        container: "form.user.page",
        dirtyField: "form.user.fullName",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Incident Report",
        route: "/incidents/new",
        role: "staff",
        container: "form.incident.page",
        dirtyField: "form.incident.description",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Timesheet Adjustment",
        route: "/timesheets/adjust",
        role: "staff",
        container: "form.timesheet.page",
        dirtyField: "form.timesheet.hours",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Lead Entry",
        route: "/leads/new",
        role: "staff",
        container: "form.lead.page",
        dirtyField: "form.lead.fullName",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Role Permissions",
        route: "/settings/roles",
        role: "staff",
        container: "form.role.page",
        dirtyField: "form.role.grid",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Message Templates",
        route: "/settings/templates",
        role: "staff",
        container: "form.template.page",
        dirtyField: "form.template.body",
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Invoice Creation",
        route: "/invoices/new",
        role: "staff",
        container: "form.invoice.page",
        dirtyField: "", // List-based, maybe no direct dirty field yet
        leaveAction: "guard.unsaved.leave",
        stayAction: "guard.unsaved.stay"
    },
    {
        name: "Shift Confirmation",
        route: "/shifts/confirm",
        role: "psw",
        container: "form.shiftConfirm.page",
        dirtyField: "", // Action-based, no transition guard needed
        leaveAction: "",
        stayAction: ""
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
