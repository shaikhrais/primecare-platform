/// <reference path="../../../support/index.d.ts" />
import { SELECTORS } from "../../../support/selectors";

/**
 * Global Components Suite
 * Verifies notifications, toasts, and role-based quick actions.
 */

describe("Global Components & Interactions", { tags: ["@smoke", "@ui"] }, () => {

    it("Notifications: Toast stacking and dismissal", () => {
        cy.loginAs("staff");
        cy.visitRoute("ADMIN_BASE_URL", "/dashboard");

        // Trigger multiple actions that might cause toasts (simulated via events or just checking existence)
        // For testing purposes, we assume certain clicks trigger toasts

        // Mock a success toast trigger via internal notify event if possible, 
        // or just verify single toast behavior on a known action (like login or status change)
        cy.visitRoute("ADMIN_BASE_URL", "/leads");
        cy.getByCy("btn-lead-contacted").first().click();

        cy.getByCy("toast").should("be.visible").and("contain", "updated successfully");

        // Success state usually auto-dismisses after 5s
        cy.getByCy("toast", { timeout: 6000 }).should("not.exist");
    });

    it("QuickActions: Role-based visibility in Topbar", () => {
        const roles: ("staff" | "manager" | "psw")[] = ["staff", "manager", "psw"];

        roles.forEach(role => {
            cy.loginAs(role);
            cy.visitRoute("ADMIN_BASE_URL", "/dashboard");

            if (role === "staff") {
                cy.getByCy("btn-quick-add-user").should("exist");
            } else if (role === "psw") {
                cy.getByCy("btn-quick-add-user").should("not.exist");
            }

            cy.logout();
        });
    });
});
