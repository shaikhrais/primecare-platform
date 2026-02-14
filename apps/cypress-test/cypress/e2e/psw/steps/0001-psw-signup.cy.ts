
/**
 * ROLE: PSW
 * AREA: SIGNUP
 * Mathematical Structure: [ROLE].[SCREEN].[COMP] NAME
 */

const signupSuite = [
    {
        id: "00.01.01",
        name: "PSW__Signup__PageLoad__SUCCESS",
        run: () => {
            cy.visit("/register?role=psw");
            cy.url().should("include", "/register");
            cy.url().should("include", "role=psw");
        }
    },
    {
        id: "00.01.02",
        name: "PSW__Signup__Logo__VISIBLE",
        run: () => {
            cy.get('img[alt="PrimeCare"]').should("be.visible");
        }
    },
    {
        id: "00.01.03",
        name: "PSW__Signup__Subtitle__CORRECT_ROLE",
        run: () => {
            cy.get('[data-cy="page.subtitle"]').should("contain", "psw");
        }
    },
    {
        id: "00.01.04",
        name: "PSW__Signup__FormFields__VISIBLE",
        run: () => {
            cy.get('[data-cy="inp-email"]').should("be.visible");
            cy.get('[data-cy="inp-password"]').should("be.visible");
            cy.get('[data-cy="inp-confirm-password"]').should("be.visible");
            cy.get('[data-cy="btn-register"]').should("be.visible");
        }
    }
];

describe("PSW Signup Micro-Steps", () => {
    before(() => {
        cy.task('resetLogs');
        cy.clearCookies();
        cy.clearLocalStorage();

        // Visit with a long timeout
        cy.visit("/register?role=psw", { timeout: 60000 });

        // Settle + Cookie handling
        cy.wait(5000);
        cy.get("body").then(($body) => {
            const btn = $body.find('button').filter((i, el) => /Accept All|Essential Only/i.test(el.innerText));
            if (btn.length > 0) cy.wrap(btn).click({ force: true, multiple: true });
        });
        cy.wait(10000);
    });

    signupSuite.forEach((s) => {
        it(`${s.id}  ${s.name}`, () => {
            s.run();
        });
    });
});
