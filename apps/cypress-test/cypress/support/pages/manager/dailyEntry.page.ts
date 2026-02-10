import { MGR } from "../../selectors/manager.cy";

export const DailyEntryPage = {
    open() {
        cy.step("Open Daily Entry page");
        cy.visit("/manager/daily-entry");
        cy.waitForByCy(MGR.dailyEntryPage);
    },

    selectClient(name: string) {
        cy.step(`Select client: ${name}`);
        cy.clickByCy(MGR.clientSelect);
        cy.clearAndTypeByCy(MGR.clientSelectInput, name);
        cy.clickByCy(MGR.clientOption0);
    },

    fillADL() {
        cy.step("Fill ADL checklist");
        cy.clickByCy(MGR.adlBathing);
        cy.clickByCy(MGR.adlFeeding);
    },

    fillVitals(bp: string, pulse: string, temp: string) {
        cy.step("Fill vitals");
        cy.clearAndTypeByCy(MGR.vitalsBp, bp);
        cy.clearAndTypeByCy(MGR.vitalsPulse, pulse);
        cy.clearAndTypeByCy(MGR.vitalsTemp, temp);
    },

    submit(signature: string) {
        cy.step("Submit daily entry");
        cy.clearAndTypeByCy(MGR.signature, signature);
        cy.clickByCy(MGR.submitEntry);
        cy.waitForByCy(MGR.toast);
        cy.getByCy(MGR.toast).should("contain.text", "Submitted");
    },
};
