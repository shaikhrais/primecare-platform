
import { Login } from "../../support/pages/auth/login.page";
import { Register } from "../../support/pages/auth/register.page";
import { SELECTORS } from "../../support/selectors";

const { MANAGER: MGR } = SELECTORS;

describe("[AUTH] Role-Based Authentication", { tags: ["@auth", "@regression"] }, () => {

    const timestamp = new Date().getTime();

    it("registers a new Client and redirects to Dashboard", () => {
        const email = `client_${timestamp}@test.com`;
        const password = "Password123!";

        cy.visitRoute("ADMIN_BASE_URL", "/register?role=client");
        Register.register(email, password);

        // After registration, should be on dashboard
        cy.url({ timeout: 15000 }).should('include', '/dashboard');
    });

    it("registers a new PSW and redirects to Dashboard", () => {
        const email = `psw_${timestamp}@test.com`;
        const password = "Password123!";

        cy.visitRoute("ADMIN_BASE_URL", "/register?role=psw");
        Register.register(email, password);

        cy.url({ timeout: 15000 }).should('include', '/dashboard');
    });

    it("registers a new Staff and redirects to Dashboard", () => {
        const email = `staff_${timestamp}@test.com`;
        const password = "Password123!";

        cy.visitRoute("ADMIN_BASE_URL", "/register?role=staff");
        Register.register(email, password);

        cy.url({ timeout: 15000 }).should('include', '/dashboard');
    });

    it("logs in as Manager", () => {
        cy.visitRoute("ADMIN_BASE_URL", "/login");
        Login.login("manager@example.com", "password");

        cy.waitForByCy(MGR.DASHBOARD.page); // Corrected to use standardized selector
        cy.url({ timeout: 15000 }).should('include', '/manager/dashboard');
    });

    it("logs in as Admin", () => {
        cy.visitRoute("ADMIN_BASE_URL", "/login");
        Login.login("admin@example.com", "password");

        cy.url({ timeout: 15000 }).should('include', '/dashboard');
    });
});
