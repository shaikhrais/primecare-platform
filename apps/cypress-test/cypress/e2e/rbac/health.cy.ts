/// <reference path="../../support/index.d.ts" />

/**
 * Quality & Health Suite
 * App-wide boot checks and console integrity.
 */

describe("Platform Health & Console Integrity", { tags: ["@smoke", "@reliability"] }, () => {

    it("Boot: Admin app boot check", () => {
        cy.visitRoute("ADMIN_BASE_URL", "/login");

        // 1. Ensure no white screen
        cy.get("#root").should("not.be.empty");

        // 2. Ensure basic UI elements ready
        cy.getByCy("inp-email").should("be.visible");

        // 3. No critical errors caught by support/e2e handler
        cy.assertNoAppCrash();
    });

    it("Boot: Marketing app boot check", () => {
        cy.visitRoute("MARKETING_BASE_URL", "/");

        // 1. Ensure marketing site rendered
        cy.get("header").should("be.visible");
        cy.get("footer").should("be.visible");

        // 2. No crashes
        cy.assertNoAppCrash();
    });
});
