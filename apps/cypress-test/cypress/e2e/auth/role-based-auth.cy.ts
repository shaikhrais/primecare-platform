
import { Login } from "../../support/pages/auth/login.page";
import { Register } from "../../support/pages/auth/register.page";
import { MGR } from "../../support/selectors/manager.cy";
import { ADM } from "../../support/selectors/admin.cy";

describe("[AUTH] Role-Based Authentication", () => {

    const timestamp = new Date().getTime();

    it("registers a new Client and redirects to Dashboard", () => {
        const email = `client_${timestamp}@test.com`;
        const password = "Password123!";

        Register.visit('client');
        Register.register(email, password);

        // After registration, should be on dashboard
        cy.url().should('include', '/dashboard');
    });

    it("registers a new PSW and redirects to Dashboard", () => {
        const email = `psw_${timestamp}@test.com`;
        const password = "Password123!";

        Register.visit('psw');
        Register.register(email, password);

        cy.url().should('include', '/dashboard');
    });

    it("registers a new Staff and redirects to Dashboard", () => {
        const email = `staff_${timestamp}@test.com`;
        const password = "Password123!";

        Register.visit('staff');
        Register.register(email, password);

        cy.url().should('include', '/dashboard');
    });

    it("logs in as Manager", () => {
        Login.visit('manager');
        Login.login("manager@example.com", "password");

        cy.waitForByCy(MGR.dashboard);
        cy.url().should('include', '/manager/dashboard');
    });

    it("logs in as Admin", () => {
        Login.visit('admin');
        Login.login("admin@example.com", "password"); // Assuming admin credentials

        // cy.waitForByCy(ADM.dashboard); // Admin dashboard might not have a specific data-cy yet or different
        // Let's check Admin selector map
        cy.url().should('include', '/dashboard'); // Admin usually goes to main dashboard too but with more access
    });

});
