import { UI_ROLE_MATRIX } from '../../support/access/ui-matrix';

describe("Enterprise UI Role Verification", { tags: ["@ui", "@rbac"] }, () => {

    Object.entries(UI_ROLE_MATRIX).forEach(([role, pages]) => {
        describe(`Role: ${role}`, () => {
            beforeEach(() => {
                // Perform login for the specific role
                cy.loginAs(role as any);
            });

            pages.forEach((page) => {
                it(`should see correct components on ${page.route}`, () => {
                    cy.visit(page.route);

                    // Verify the page title or container exists
                    cy.get('body').should('be.visible');

                    // Verify each defined element exists
                    page.elements.forEach((element) => {
                        if (element.startsWith('[data-cy=')) {
                            cy.get(element).should('exist');
                        } else {
                            cy.contains(element, { matchCase: false }).should('exist');
                        }
                    });
                });
            });

            // Negative check: PSW should not access Admin pages
            if (role === 'psw') {
                it("should be denied access to admin users page", () => {
                    cy.visit('/admin/users', { failOnStatusCode: false });
                    // Expect redirect to login/dashboard or a 403-style UI
                    cy.url().should('not.include', '/admin/users');
                });
            }
        });
    });
});
