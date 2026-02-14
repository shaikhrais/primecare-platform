
/**
 * ROLE 02: RN
 * Mathematical Structure: [ROLE].[SCREEN].[COMP] NAME
 */

const rnFullSuite = [
    // 02.01: LOGIN
    {
        id: "02.01.01", name: "RN__Login__PageLoad__SUCCESS", run: () => {
            cy.task('resetLogs');
            cy.clearCookies();
            cy.clearLocalStorage();
            cy.visit("/login", { timeout: 60000 });

            // Aggressive settle + cookie handling
            cy.wait(5000);
            cy.get("body").then(($body) => {
                const btn = $body.find('button').filter((i, el) => /Accept All|Essential Only/i.test(el.innerText));
                if (btn.length > 0) cy.wrap(btn).click({ force: true, multiple: true });
            });
            cy.wait(10000);

            cy.url().should("include", "/login");
            cy.get('input[type="email"]', { timeout: 15000 }).should('be.visible');
        }
    },
    { id: "02.01.02", name: "RN__Login__Logo__VISIBLE", run: () => { cy.get('img[alt="PrimeCare"]').should("be.visible"); } },
    { id: "02.01.03", name: "RN__Login__EmailInput__VISIBLE", run: () => { cy.get('input[type="email"]').should("be.visible"); } },
    {
        id: "02.01.09", name: "RN__Login__ValidLogin__REDIRECT", run: () => {
            const email = Cypress.env("RN_EMAIL") || "rn.a@primecare.ca";
            const password = Cypress.env("RN_PASSWORD") || "admin123";
            cy.get('input[type="email"]').clear({ force: true }).type(email, { delay: 0 });
            cy.get('input[type="password"]').clear({ force: true }).type(password, { delay: 0 });
            cy.contains('button', /Sign in/i).click({ force: true });
            cy.url({ timeout: 45000 }).should("include", "/dashboard");
            cy.contains('Nurse', { timeout: 15000 }).should('be.visible');
        }
    },

    // 02.02: DASHBOARD
    { id: "02.02.01", name: "RN__Dashboard__PageLoad__SUCCESS", run: () => { cy.url().should("include", "/dashboard"); } },
    { id: "02.02.02", name: "RN__Dashboard__Stats__VISIBLE", run: () => { cy.get('[data-testid="stats-grid"]').should("exist"); } },

    // 02.03: PATIENTS
    { id: "02.03.01", name: "RN__Patients__PageLoad__SUCCESS", run: () => { cy.visit("/rn/patients"); cy.url().should("include", "/patients"); } },
    { id: "02.03.02", name: "RN__Patients__Table__VISIBLE", run: () => { cy.get('table').should("be.visible"); } },
    { id: "02.03.05", name: "RN__Patients__AddPatient__MODAL_OPEN", run: () => { cy.contains('button', /Add Patient/i).click(); cy.get('[role="dialog"]').should("be.visible"); cy.get('button').contains(/Cancel|Close/i).click(); } },

    // 02.05: CARE PLANS
    { id: "02.05.01", name: "RN__CarePlans__PageLoad__SUCCESS", run: () => { cy.visit("/rn/care-plans"); cy.url().should("include", "/care-plans"); } },
    { id: "02.05.02", name: "RN__CarePlans__CreateButton__VISIBLE", run: () => { cy.get('button').contains(/Create Plan/i).should("be.visible"); } },

    // 02.10: RBAC
    {
        id: "02.10.01", name: "RN__RBAC__AdminSettings__DENIED", run: () => {
            cy.visit("/admin/settings", { failOnStatusCode: false });
            cy.contains(/unauthorized|forbidden|not found|access denied/i, { timeout: 10000 }).should("be.visible");
        }
    },
];

describe("RN Mathematical Micro-Steps (Full Suite)", () => {
    // Setup moved to first test for better error reporting
    rnFullSuite.forEach((s) => {
        it(`${s.id}  ${s.name}`, () => {
            s.run();
        });
    });
});
