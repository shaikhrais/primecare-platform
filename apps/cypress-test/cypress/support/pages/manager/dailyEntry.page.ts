import { MGR } from "../../selectors/manager.cy";

export const DailyEntryPage = {
    open() {
        cy.step("Open Daily Entry page");
        cy.visit("/manager/daily-entry");
        cy.waitForByCy(MGR.dailyEntryPage);
    },

    selectClient(name: string) {
        cy.step(`Select client: ${name}`);
        // The component uses a native select, but we likely need to select by value (ID) or text.
        // Since the test might pass the name, we should find the option with that text.
        cy.getByCy(MGR.clientSelect).select(name);
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
