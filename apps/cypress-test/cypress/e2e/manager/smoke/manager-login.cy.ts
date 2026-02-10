import { MGR } from "../../../support/selectors/manager.cy";

describe("[SMOKE] Manager Login", () => {
    it("logs in successfully via UI", () => {
        cy.step("Open Manager Login");
        cy.visit("/login");
        cy.waitForPageReady();

        cy.step("Enter Credentials");
        cy.clearAndTypeByCy(MGR.loginEmail, "manager@example.com"); // Replace with env if needed
        cy.clearAndTypeByCy(MGR.loginPassword, "password");
        cy.clickByCy(MGR.loginSubmit);

        cy.step("Verify Dashboard");
        cy.waitForByCy(MGR.dashboard);
        cy.shouldSeeByCy(MGR.qaDailyEntry);
    });
});
