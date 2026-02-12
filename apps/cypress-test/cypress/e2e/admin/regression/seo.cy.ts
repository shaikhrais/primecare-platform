/// <reference path="../../../support/index.d.ts" />
import { SELECTORS } from "../../../support/selectors";

/**
 * SEO & Responsive Suite
 * Verifies marketing metadata and mobile layout behavior.
 */

describe("SEO & Responsive Verification", { tags: ["@marketing", "@smoke"] }, () => {

    const MARKETING_URLS = [
        { path: "/", title: "PrimeCare - Compassionate Care Solutions", h1: "Welcome to PrimeCare" },
        { path: "/services", title: "Our Services | PrimeCare", h1: "Comprehensive Care Services" },
        { path: "/contact", title: "Contact Us | PrimeCare", h1: "Get in Touch" }
    ];

    it("SEO: Verify Title, Meta Description and H1 tags", () => {
        MARKETING_URLS.forEach(page => {
            cy.visitRoute("MARKETING_BASE_URL", page.path);

            // 1. Title check
            cy.title().should("eq", page.title);

            // 2. Meta description presence
            cy.get('meta[name="description"]').should("have.attr", "content").and("not.be.empty");

            // 3. Single H1 check
            cy.get("h1").should("have.length", 1).and("contain", page.h1);

            // 4. OG Tags (Essentials)
            cy.get('meta[property="og:title"]').should("exist");
        });
    });

    it("Responsive: Mobile menu visibility at 375x667", () => {
        cy.viewport("iphone-6");
        cy.visitRoute("MARKETING_BASE_URL", "/");

        // 1. Desktop Nav should be hidden
        cy.getByCy("desktop-nav").should("not.be.visible");

        // 2. Mobile trigger should be visible
        cy.getByCy("mobile-menu-trigger").should("be.visible").click();

        // 3. Mobile menu should expand
        cy.getByCy("mobile-menu").should("be.visible");
    });
});
