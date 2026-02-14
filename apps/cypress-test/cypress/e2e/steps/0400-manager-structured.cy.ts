
/**
 * ROLE 04: Manager
 * Mathematical Structure: [ROLE].[SCREEN].[COMP] NAME
 */

const managerFullSuite = [
    // 04.01: LOGIN
    {
        id: "04.01.01", name: "Manager__Login__PageLoad__SUCCESS", run: () => {
            cy.task('resetLogs');
            cy.clearCookies();
            cy.clearLocalStorage();
            cy.log('Visiting login page...');
            cy.visit("/login", { timeout: 60000 });

            // Aggressive settle + heartbeat
            cy.log('Initial settle (5s)...');
            cy.wait(5000);

            cy.log('Checking for cookie banner...');
            cy.get("body").then(($body) => {
                const btn = $body.find('button').filter((i, el) => /Accept All|Essential Only/i.test(el.innerText));
                if (btn.length > 0) {
                    cy.log('Cookie button found, clicking...');
                    cy.wrap(btn).click({ force: true, multiple: true });
                } else {
                    cy.log('No cookie button found yet.');
                }
            });

            cy.log('Final settle (10s)...');
            cy.wait(10000);

            cy.log('Verifying stable state...');
            cy.url().should("include", "/login");
            cy.get('input[type="email"]', { timeout: 20000 }).should('be.visible');
            cy.log('Page stabilized.');
        }
    },
    { id: "04.01.02", name: "Manager__Login__Logo__VISIBLE", run: () => { cy.get('img[alt="PrimeCare"]').should("be.visible"); } },
    {
        id: "04.01.09", name: "Manager__Login__ValidLogin__REDIRECT", run: () => {
            const email = Cypress.env("MANAGER_EMAIL") || "manager.a@primecare.ca";
            const password = Cypress.env("MANAGER_PASSWORD") || "admin123";
            cy.get('input[type="email"]').clear({ force: true }).type(email, { delay: 0 });
            cy.get('input[type="password"]').clear({ force: true }).type(password, { delay: 0 });
            cy.contains('button', /Sign in/i).click({ force: true });
            cy.url({ timeout: 45000 }).should("include", "/dashboard");
            cy.contains('Manager', { timeout: 15000 }).should('be.visible');
        }
    },

    // 04.02: DASHBOARD
    { id: "04.02.01", name: "Manager__Dashboard__PageLoad__SUCCESS", run: () => { cy.url().should("include", "/dashboard"); } },
    { id: "04.02.02", name: "Manager__Dashboard__SummaryCards__VISIBLE", run: () => { cy.get('[data-testid="summary-cards"]').should("exist"); } },

    // 04.03: AGENCY MANAGEMENT
    { id: "04.03.01", name: "Manager__Agency__PageLoad__SUCCESS", run: () => { cy.visit("/manager/agencies"); cy.url().should("include", "/agencies"); } },
    { id: "04.03.02", name: "Manager__Agency__AgenciesTable__VISIBLE", run: () => { cy.get('table').should("be.visible"); } },

    // 04.10: RBAC
    { id: "04.10.01", name: "Manager__RBAC__AdminRoute__DENIED", run: () => { cy.visit("/admin/settings", { failOnStatusCode: false }); cy.contains(/unauthorized|forbidden|not found/i).should("be.visible"); } },
];

describe("Manager Mathematical Micro-Steps (Full Suite)", () => {
    // Setup handled in 04.01.01
    managerFullSuite.forEach((s) => {
        it(`${s.id}  ${s.name}`, () => {
            s.run();
        });
    });
});
