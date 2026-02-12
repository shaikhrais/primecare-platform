export class RegisterPage {
    private selectors = {
        emailInput: 'inp-email',
        passwordInput: 'inp-password',
        confirmPasswordInput: 'inp-confirm-password',
        submitButton: 'btn-register',
        loginLink: 'link-login'
    };

    visit(role: 'client' | 'psw' | 'staff' = 'client') {
        const url = `/register?role=${role}`;
        cy.step(`Visit Register Page as ${role}`);
        cy.visit(url);
        cy.waitForPageReady();
    }

    register(email: string, password: string) {
        cy.step(`Register as ${email}`);
        cy.clearAndTypeByCy(this.selectors.emailInput, email);
        cy.clearAndTypeByCy(this.selectors.passwordInput, password);
        cy.clearAndTypeByCy(this.selectors.confirmPasswordInput, password);
        cy.clickByCy(this.selectors.submitButton);
    }
}

export const Register = new RegisterPage();
