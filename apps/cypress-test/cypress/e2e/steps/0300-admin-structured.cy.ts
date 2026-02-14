
/**
 * ROLE 03: Admin
 * Mathematical Structure: [ROLE].[SCREEN].[COMP] NAME
 */

const adminFullSuite = [
    // 03.01: LOGIN
    {
        id: "03.01.01", name: "Admin__Login__PageLoad__SUCCESS", run: () => {
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
    { id: "03.01.02", name: "Admin__Login__Logo__VISIBLE", run: () => { cy.get('img[alt="PrimeCare"]').should("be.visible"); } },
    {
        id: "03.01.09", name: "Admin__Login__ValidLogin__REDIRECT", run: () => {
            const email = Cypress.env("ADMIN_EMAIL") || "admin.a@primecare.ca";
            const password = Cypress.env("ADMIN_PASSWORD") || "admin123";
            cy.get('input[type="email"]').clear({ force: true }).type(email, { delay: 0 });
            cy.get('input[type="password"]').clear({ force: true }).type(password, { delay: 0 });
            cy.contains('button', /Sign in/i).click({ force: true });
            cy.url({ timeout: 45000 }).should("include", "/dashboard");
            cy.contains('Administrator', { timeout: 15000 }).should('be.visible');
        }
    },

    // 03.02: DASHBOARD
    { id: "03.02.01", name: "Admin__Dashboard__PageLoad__SUCCESS", run: () => { cy.url().should("include", "/dashboard"); } },
    { id: "03.02.02", name: "Admin__Dashboard__AdminStats__VISIBLE", run: () => { cy.get('[data-testid="admin-stats"]').should("exist"); } },

    // 03.03: USERS
    { id: "03.03.01", name: "Admin__Users__PageLoad__SUCCESS", run: () => { cy.visit("/admin/users"); cy.url().should("include", "/admin/users"); } },
    { id: "03.03.02", name: "Admin__Users__Table__VISIBLE", run: () => { cy.get('table').should("be.visible"); } },
    { id: "03.03.03", name: "Admin__Users__AddUserButton__VISIBLE", run: () => { cy.contains('button', /Add User/i).should("be.visible"); } },

    // 03.04: AUDITS
    { id: "03.04.01", name: "Admin__Audits__PageLoad__SUCCESS", run: () => { cy.visit("/admin/audits"); cy.url().should("include", "/admin/audits"); } },
    { id: "03.04.02", name: "Admin__Audits__LogTable__VISIBLE", run: () => { cy.get('table').should("be.visible"); } },

    // 03.05: SETTINGS
    { id: "03.05.01", name: "Admin__Settings__PageLoad__SUCCESS", run: () => { cy.visit("/admin/settings"); cy.url().should("include", "/admin/settings"); } },
    { id: "03.05.02", name: "Admin__Settings__SystemTitle__VISIBLE", run: () => { cy.contains(/System Settings/i).should("be.visible"); } },

    // 03.10: RBAC (Self-check)
    {
        id: "03.10.01", name: "Admin__RBAC__FullAccess__GRANTED", run: () => {
            cy.visit("/admin/settings");
            cy.contains(/unauthorized|forbidden|not found/i).should("not.exist");
            cy.contains(/System Settings/i).should("be.visible");
        }
    },
];

describe("Admin Mathematical Micro-Steps (Full Suite)", () => {
    // Setup handled in 03.01.01
    adminFullSuite.forEach((s) => {
        it(`${s.id}  ${s.name}`, () => {
            s.run();
        });
    });
});
