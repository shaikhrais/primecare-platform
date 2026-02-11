
Cypress.on('uncaught:exception', (err, runnable) => {
  // returning false here prevents Cypress from failing the test
  return false;
});

describe("Generated: RBAC Action Visibility", { tags: ["@integrity", "@security"] }, () => {
    const cfg = {"roles":["guest","client","psw","manager","staff"],"global":{"mandatory":["page.container","page.header","page.title","nav.main","toast","state.loading"],"selectors":{"sidebar":"sidebar","topbar":"topbar","logout":"btn-logout","toast":"toast","loading":"state.loading","error":"state.error","empty":"state.empty","accessDenied":"state.accessDenied"}},"pages":[{"key":"MARKETING_HOME","path":"/","baseUrlEnv":"WEB_MARKETING_BASE_URL","allowedRoles":["guest","any"],"components":["logo-link","link-family-portal","link-staff-hub","btn-book-assessment"],"actions":[{"key":"bookAssessment","selector":"btn-book-assessment","type":"route","target":"/book-now"},{"key":"loginFamily","selector":"link-family-portal","type":"route","target":"/login"},{"key":"loginStaff","selector":"link-staff-hub","type":"route","target":"/staff-login"}]},{"key":"MARKETING_CONTACT","path":"/contact","baseUrlEnv":"WEB_MARKETING_BASE_URL","allowedRoles":["guest","any"],"components":["inp-name","inp-email","inp-phone","inp-message","btn-submit-contact"],"actions":[{"key":"submitContact","selector":"btn-submit-contact","type":"api","endpoint":"/leads","method":"POST","expectedToasts":["contact-success"]}]},{"key":"AUTH_LOGIN","path":"/login","baseUrlEnv":"WEB_ADMIN_BASE_URL","allowedRoles":["guest"],"components":["inp-email","inp-password","btn-login"],"actions":[{"key":"login","selector":"btn-login","type":"api","endpoint":"/auth/login","method":"POST"}]},{"key":"ADMIN_DASHBOARD","path":"/dashboard","baseUrlEnv":"WEB_ADMIN_BASE_URL","allowedRoles":["staff","manager"],"components":["qa-link-users","qa-link-schedule","qa-link-leads","qa-link-settings"],"actions":[{"key":"navUsers","selector":"qa-link-users","type":"route","target":"/users"},{"key":"navSchedule","selector":"qa-link-schedule","type":"route","target":"/schedule"},{"key":"navLeads","selector":"qa-link-leads","type":"route","target":"/leads"},{"key":"navSettings","selector":"qa-link-settings","type":"route","target":"/settings"}]},{"key":"ADMIN_USERS","path":"/users","baseUrlEnv":"WEB_ADMIN_BASE_URL","allowedRoles":["staff"],"components":["btn-invite-user","tbl-users"],"actions":[{"key":"inviteUser","selector":"btn-invite-user","type":"api","endpoint":"/users/invite","method":"POST"}]},{"key":"ADMIN_SCHEDULE","path":"/schedule","baseUrlEnv":"WEB_ADMIN_BASE_URL","allowedRoles":["staff","manager"],"components":["calendar-container","btn-create-shift"],"actions":[{"key":"createShift","selector":"btn-create-shift","type":"api","endpoint":"/shifts","method":"POST"}]},{"key":"ADMIN_SERVICES","path":"/services","baseUrlEnv":"WEB_ADMIN_BASE_URL","allowedRoles":["staff"],"components":["btn-add-service","tbl-services"],"actions":[{"key":"addService","selector":"btn-add-service","type":"api","endpoint":"/services","method":"POST"}]},{"key":"ADMIN_SETTINGS","path":"/settings","baseUrlEnv":"WEB_ADMIN_BASE_URL","allowedRoles":["staff"],"components":["chk-email-alerts","chk-auto-assign","btn-save-settings"],"integrity":"guard.unsaved","actions":[{"key":"saveSettings","selector":"btn-save-settings","type":"api","endpoint":"/settings","method":"PATCH"}]},{"key":"MANAGER_DASHBOARD","path":"/manager/dashboard","baseUrlEnv":"WEB_ADMIN_BASE_URL","allowedRoles":["manager"],"components":["mgr-dashboard"],"actions":[{"key":"navDailyEntry","selector":"qa-daily-entry","type":"route","target":"/manager/daily-entry"}]},{"key":"MANAGER_DAILY_ENTRY","path":"/manager/daily-entry","baseUrlEnv":"WEB_ADMIN_BASE_URL","allowedRoles":["manager"],"components":["daily-entry-page","client-select","vitals-bp","notes","submit-entry"],"integrity":"guard.unsaved","actions":[{"key":"submitEntry","selector":"submit-entry","type":"api","endpoint":"/daily-entry/submit","method":"POST"}]},{"key":"PSW_SHIFTS","path":"/shifts","baseUrlEnv":"WEB_ADMIN_BASE_URL","allowedRoles":["psw"],"components":["sidebar","topbar"],"actions":[]},{"key":"CLIENT_BOOKINGS","path":"/bookings","baseUrlEnv":"WEB_ADMIN_BASE_URL","allowedRoles":["client"],"components":["sidebar","topbar"],"actions":[]},{"key":"SHARED_PROFILE","path":"/profile","baseUrlEnv":"WEB_ADMIN_BASE_URL","allowedRoles":["client","psw","manager","staff"],"components":["btn-save-settings"],"integrity":"guard.unsaved","actions":[{"key":"saveProfile","selector":"btn-save-settings","type":"api","endpoint":"/profile","method":"PATCH"}]}]};
    const roles = cfg.roles;

    cfg.pages.forEach((page: any) => {
        roles.forEach((role: string) => {
            it(`[${page.key}] verifies visibility for role: ${role}`, () => {
                const allowed = page.allowedRoles.includes(role) || page.allowedRoles.includes("any");
                
                cy.logout();
                if (role !== "guest") cy.loginAs(role as any);
                
                const baseUrlEnv = page.baseUrlEnv || "ADMIN_BASE_URL";
                cy.visitRoute(baseUrlEnv, page.path, { failOnStatusCode: false });

                if (!allowed) {
                    if (role === "guest") {
                        cy.assertRedirectToLogin();
                    } else {
                        // Authenticated user but not allowed on this specific page
                        // They should be redirected away from the page.path
                        cy.url().should("not.include", page.path);
                    }
                } else {
                    page.actions.forEach((action: any) => {
                        cy.log(`Verifying action visibility: ${action.key}`);
                        cy.getByCy(action.selector).should("be.visible");
                    });
                }
            });
        });
    });
});
