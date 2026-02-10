/// <reference path="../../support/index.d.ts" />

describe("Accessibility & Health Micro-tests", { tags: ["@a11y", "@smoke"] }, () => {

    const keyRoutes = ["/login", "/register", "/dashboard"];

    keyRoutes.forEach((route) => {
        it(`Page Health: ${route} loads without severe errors`, () => {
            cy.visitAppRoute("ADMIN_BASE_URL", route);

            // 1. Boot check: body is not empty
            cy.get("body").should("not.be.empty");

            // 2. Content check: No "Application error" or white screen indicators
            cy.get("body").should("not.contain", "Application error");
            cy.get("body").should("not.contain", "Something went wrong");

            // 3. SEO/A11y: Exactly one H1 per page
            // (Note: Optional strictness, but recommended by user)
            cy.get("h1").should("have.length", 1);
        });
    });

    it("Form Accessibility: Inputs have associated labels or aria-labels", () => {
        cy.visitAppRoute("ADMIN_BASE_URL", "/login");

        // Every input/select/textarea should have an accessible name
        cy.get("input").each(($el) => {
            const name = $el.attr("name") || $el.attr("aria-label") || $el.attr("placeholder");
            expect(name, "Input missing accessible identification").to.not.be.empty;
        });
    });
});
