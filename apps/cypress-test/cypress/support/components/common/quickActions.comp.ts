import { SELECTORS } from "../../selectors";
const { MANAGER, COMMON } = SELECTORS;
const MGR_DAILY = MANAGER.DAILY_ENTRY;

export const QuickActions = {
    openDailyEntry() {
        cy.step("Quick Action: Daily Entry");
        cy.clickByCy(COMMON.qaDailyEntry);
    },
    addClient() {
        cy.step("Quick Action: Add Client");
        cy.clickByCy(COMMON.qaAddClient);
    },
};
