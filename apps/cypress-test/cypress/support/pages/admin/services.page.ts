import { ADMIN } from "../../selectors/admin.cy";

export const ServicesPage = {
    visit() {
        cy.step("Visit Services Page");
        cy.visit("/admin/services");
        cy.waitForByCy(ADMIN.btnAddService);
    },

    openAddServiceModal() {
        cy.step("Open Add Service Modal");
        cy.clickByCy(ADMIN.btnAddService);
        cy.waitForByCy(ADMIN.inpServiceName);
    },

    fillServiceForm(name: string, rate: number, category: string, desc: string) {
        cy.step(`Fill Service Form: ${name}`);
        cy.clearAndTypeByCy(ADMIN.inpServiceName, name);
        cy.clearAndTypeByCy(ADMIN.inpServiceRate, rate.toString());
        cy.getByCy(ADMIN.selServiceCategory).select(category);
        cy.clearAndTypeByCy(ADMIN.inpServiceDesc, desc);
    },

    saveService() {
        cy.step("Save Service");
        cy.clickByCy(ADMIN.btnSaveService);
        // Wait for modal to close or toast
    },

    addService(name: string, rate: number, category: string, desc: string) {
        this.openAddServiceModal();
        this.fillServiceForm(name, rate, category, desc);
        this.saveService();
        cy.contains(name).should('be.visible');
    },

    deleteService(name: string) {
        cy.step(`Delete Service: ${name}`);
        // Find row by text "name" then find delete button within it? 
        // Or simpler, just click the delete button in the row that contains the text
        cy.contains('tr', name).within(() => {
            cy.get('button[data-cy^="btn-delete-service"]').click();
        });
        // Handle confirm dialog if needed? The component uses `confirm()`.
        // Cypress auto-accepts confirms, but we might need to rely on that behavior.
    }
};
