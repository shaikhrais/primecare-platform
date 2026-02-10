import { COMMON } from "../../selectors/common.cy";

export const ProfilePage = {
    visit() {
        cy.step("Visit Profile Page");
        cy.visit("/profile");
        // Wait for profile data to load?
        cy.waitForByCy(COMMON.btnSaveProfile);
    },

    updateProfile(fullname: string, bioOrAddress: string, city?: string) {
        cy.step(`Update Profile: ${fullname}`);
        cy.clearAndTypeByCy(COMMON.inpFullname, fullname);

        // Conditional logic based on role would be here, but simpler to try both or rely on specific usage
        // Let's assume we know what fields are visible or just try to find them if they exist
        cy.get('body').then($body => {
            if ($body.find(`[data-cy="${COMMON.inpBio}"]`).length > 0) {
                cy.clearAndTypeByCy(COMMON.inpBio, bioOrAddress);
            } else if ($body.find(`[data-cy="${COMMON.inpAddress}"]`).length > 0) {
                cy.clearAndTypeByCy(COMMON.inpAddress, bioOrAddress);
                if (city) cy.clearAndTypeByCy(COMMON.inpCity, city);
            }
        });
    },

    save() {
        cy.step("Save Profile");
        cy.clickByCy(COMMON.btnSaveProfile);
        cy.contains("Profile updated").should('be.visible');
    }
};
