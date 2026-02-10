/// <reference path="../../support/index.d.ts" />

describe("Admin Table Interactions", { tags: ["@admin", "@regression"] }, () => {

    beforeEach(() => {
        cy.loginAs("staff");
    });

    it("Leads Table: Status update transition", () => {
        const LEADS_API = "**/api/admin/leads";
        const LEAD_ID = "lead-123";

        // 1. Stub initial leads
        cy.intercept("GET", LEADS_API, [
            { id: LEAD_ID, fullName: "John Lead", email: "john@lead.com", status: "new", createdAt: new Date().toISOString() }
        ]).as("getLeads");

        cy.visitAppRoute("ADMIN_BASE_URL", "/leads");
        cy.wait("@getLeads");

        // 2. Intercept the patch request
        cy.intercept("PATCH", `**/api/admin/leads/${LEAD_ID}`, {
            statusCode: 200,
            body: { success: true }
        }).as("updateStatus");

        // 3. Trigger transition to 'contacted'
        cy.getByCy("btn-lead-contacted").click();
        cy.wait("@updateStatus");

        // 4. Verify UI update
        cy.getByCy("lead-status").should("contain", "contacted");
    });

    it("Users Table: ID Verification flow (PSW)", () => {
        const USERS_API = "**/api/admin/users";
        const USER_ID = "psw-456";

        cy.intercept("GET", USERS_API, [
            {
                id: USER_ID, email: "walker@primecare.ca", role: "psw", status: "pending",
                PswProfile: { fullName: "John Walker" }
            }
        ]).as("getUsers");

        cy.visitAppRoute("ADMIN_BASE_URL", "/users");
        cy.wait("@getUsers");

        cy.intercept("POST", `**/api/admin/users/verify/${USER_ID}`, {
            statusCode: 200,
            body: { success: true }
        }).as("verifyUser");

        // Approved icon should change from ⏳ to ✅
        cy.getByCy("user-verification-icon").should("contain", "⏳");
        cy.getByCy("btn-verify-user").click();
        cy.wait("@verifyUser");

        cy.getByCy("user-verification-icon").should("contain", "✅");
        cy.getByCy("toast").should("contain", "verified successfully");
    });
});
