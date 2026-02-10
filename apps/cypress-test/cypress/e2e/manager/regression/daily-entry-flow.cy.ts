import { QuickActions } from "../../../support/components/common/quickActions.comp";
import { DailyEntryPage } from "../../../support/pages/manager/dailyEntry.page";
import { MGR } from "../../../support/selectors/manager.cy";

describe("[REGRESSION] Manager Daily Entry Flow", () => {
    beforeEach(() => {
        cy.interceptManagerCore();

        cy.step("Open Manager login");
        cy.visit("/login");
        cy.waitForPageReady();

        cy.step("Login");
        cy.clearAndTypeByCy(MGR.loginEmail, Cypress.env("MANAGER_EMAIL") || "manager@example.com");
        cy.clearAndTypeByCy(MGR.loginPassword, Cypress.env("MANAGER_PASSWORD") || "password");
        cy.clickByCy(MGR.loginSubmit);

        cy.step("Wait dashboard API and UI");
        cy.wait("@getDashboard");
        cy.waitForByCy(MGR.dashboard);
    });

    it("creates daily entry via Quick Actions", () => {
        cy.step("Open Daily Entry from Quick Action bar");
        QuickActions.openDailyEntry();
        cy.waitForByCy(MGR.dailyEntryPage);

        DailyEntryPage.selectClient("John");
        DailyEntryPage.fillADL();
        DailyEntryPage.fillVitals("120/80", "72", "36.7");
        cy.clearAndTypeByCy(MGR.notes, "Stable. No pain. Good mood.");

        DailyEntryPage.submit("Rahil");
        cy.wait("@postDailyEntry");
    });
});
