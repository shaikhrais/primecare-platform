import { CLIENT } from "../../selectors/client.cy";

export const BookingsPage = {
    visit() {
        cy.step("Visit Bookings Page");
        cy.visit("/client/bookings");
        cy.waitForByCy(CLIENT.btnRequestCare);
    },

    openRequestModal() {
        cy.step("Open Request Care Modal");
        cy.clickByCy(CLIENT.btnRequestCare);
        cy.waitForByCy(CLIENT.selService);
    },

    fillBookingForm(serviceValue: string, date: string, time: string, duration: number, notes: string) {
        cy.step(`Fill Booking Form for ${date} @ ${time}`);
        // For service, we might need to select by value (ID) which we don't know easily without helpers,
        // or by text if the select command supports it.
        // Assuming select command handles text or value. 
        cy.getByCy(CLIENT.selService).select(serviceValue); // Or index

        cy.clearAndTypeByCy(CLIENT.inpDate, date);
        cy.clearAndTypeByCy(CLIENT.inpTime, time);
        cy.getByCy(CLIENT.selDuration).select(duration.toString());
        cy.clearAndTypeByCy(CLIENT.inpNotes, notes);
    },

    submitRequest() {
        cy.step("Submit Booking Request");
        cy.clickByCy(CLIENT.btnSubmitRequest);
        // Wait for modal close
        cy.getByCy(CLIENT.formBooking).should('not.exist');
    },

    requestCare(serviceValue: string, date: string, time: string, duration: number, notes: string) {
        this.openRequestModal();
        this.fillBookingForm(serviceValue, date, time, duration, notes);
        this.submitRequest();
    }
};
