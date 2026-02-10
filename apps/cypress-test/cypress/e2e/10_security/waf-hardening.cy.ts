/// <reference path="../../support/index.d.ts" />

/**
 * Security & WAF Hardening Suite
 * Verifies security headers and basic injection resistance.
 */

describe("Security & WAF Hardening", { tags: ["@security", "@waf"] }, () => {

    beforeEach(() => {
        cy.visitRoute("ADMIN_BASE_URL", "/login");
    });

    it("WAF: Verify Security Headers in server response", () => {
        cy.request({
            url: Cypress.env("ADMIN_BASE_URL"),
            method: "GET"
        }).then((response) => {
            // Essential security headers
            expect(response.headers).to.have.property("x-content-type-options", "nosniff");

            // We can also check for CSP or HSTS if enforced
            // expect(response.headers).to.have.property("content-security-policy");
        });
    });

    it("Security: Auth inputs resist basic SQL Injection attempts", () => {
        const sqlPayload = "' OR 1=1 --";

        cy.getByCy("inp-email").type(sqlPayload);
        cy.getByCy("inp-password").type("wrongpassword");
        cy.getByCy("btn-login").click();

        // System should not crash and should show unauthorized
        cy.assertNoAppCrash();
        cy.getByCy("toast").should("be.visible").and("contain", "Invalid credentials");
    });

    it("Security: Search params resist basic XSS Injection", () => {
        // Many apps reflect search params. We ensure it's escaped.
        const xssPayload = "<script>alert('xss')</script>";
        const encodedPayload = encodeURIComponent(xssPayload);

        cy.visitRoute("ADMIN_BASE_URL", `/users?search=${encodedPayload}`);

        // Assert no alert popped or script executed (Cypress handles uncaught exceptions if script runs)
        // AND ensure the literal string is rendered safest (escaped)
        cy.get("body").should("not.contain", xssPayload);
    });
});
