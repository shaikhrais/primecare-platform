import { MGR } from "../../selectors/manager.cy";

export const QuickActions = {
    openDailyEntry() {
        cy.step("Quick Action: Daily Entry");
        cy.clickByCy(MGR.qaDailyEntry);
    },
    addClient() {
        cy.step("Quick Action: Add Client");
        cy.clickByCy(MGR.qaAddClient);
    },
};
