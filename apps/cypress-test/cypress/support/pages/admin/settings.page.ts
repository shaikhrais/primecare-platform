import { ADMIN } from "../../selectors/admin.cy";

export const SettingsPage = {
    visit() {
        cy.step("Visit Settings Page");
        cy.visit("/admin/settings");
        cy.waitForByCy(ADMIN.btnSaveSettings);
    },

    toggleEmailAlerts(enable: boolean) {
        cy.step(`Set Email Alerts to ${enable}`);
        cy.getByCy(ADMIN.chkEmailAlerts).then($chk => {
            if ($chk.is(':checked') !== enable) {
                cy.wrap($chk).click();
            }
        });
    },

    toggleAutoAssign(enable: boolean) {
        cy.step(`Set Auto Assign to ${enable}`);
        cy.getByCy(ADMIN.chkAutoAssign).then($chk => {
            if ($chk.is(':checked') !== enable) {
                cy.wrap($chk).click();
            }
        });
    },

    selectGracePeriod(period: string) {
        cy.step(`Select Grace Period: ${period}`);
        cy.getByCy(ADMIN.selGracePeriod).select(period);
    },

    save() {
        cy.step("Save Settings");
        cy.clickByCy(ADMIN.btnSaveSettings);
        // cy.contains("Success").should('be.visible');
    },

    reset() {
        cy.step("Reset Settings");
        cy.clickByCy(ADMIN.btnResetSettings);
    }
};
