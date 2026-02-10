export class LoginPage {
    private selectors = {
        emailInput: 'inp-email',
        passwordInput: 'inp-password',
        submitButton: 'btn-login'
    };

    visit(role: 'admin' | 'manager' | 'psw' | 'client' | 'staff' = 'client') {
        // For admin and manager, the route is just /login based on previous tests
        // For others, we might want to query param to trigger specific UI or just use /login
        // The Login.tsx handles ?role=param for UI text, so let's respect that.
        const url = (role === 'admin' || role === 'manager')
            ? '/login'
            : `/login?role=${role}`;

        cy.step(`Visit Login Page as ${role}`);
        cy.visit(url);
        cy.waitForPageReady();
    }

    login(email: string, password: string) {
        cy.step(`Login as ${email}`);
        cy.clearAndTypeByCy(this.selectors.emailInput, email);
        cy.clearAndTypeByCy(this.selectors.passwordInput, password);
        cy.clickByCy(this.selectors.submitButton);
    }
}

export const Login = new LoginPage();
