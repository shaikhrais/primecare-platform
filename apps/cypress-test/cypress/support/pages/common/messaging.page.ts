import { COMMON } from "../../selectors/common.cy";

export const MessagingPage = {
    visit() {
        cy.step("Visit Messaging Portal");
        cy.visit("/messages");
        cy.waitForByCy(COMMON.btnSendMessage);
    },

    sendMessage(text: string) {
        cy.step(`Send Message: ${text}`);
        cy.clearAndTypeByCy(COMMON.inpMessage, text);
        cy.clickByCy(COMMON.btnSendMessage);
    },

    verifyMessageSent(text: string) {
        cy.step("Verify Message Sent");
        cy.getByCy(COMMON.listMessages).contains(text).should('be.visible');
    }
};
