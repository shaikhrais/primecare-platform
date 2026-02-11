
Cypress.on('uncaught:exception', (err, runnable) => {
  // returning false here prevents Cypress from failing the test
  return false;
});

describe("Generated: Action Integrity", { tags: ["@integrity", "@functional"] }, () => {
    const cfg = {"roles":["guest","client","psw","manager","staff"],"pages":[{"key":"ADMIN_DASHBOARD","path":"/dashboard","allowedRoles":["staff","manager"],"components":["page.container","page.header","page.title","nav.main","stats-cards"],"actions":[{"key":"btn.quickUsers","target":"/users","type":"route"},{"key":"btn.quickSchedule","target":"/schedule","type":"route"},{"key":"btn.quickLeads","target":"/leads","type":"route"}]},{"key":"USER_LIST","path":"/users","allowedRoles":["staff"],"components":["page.container","page.title","tbl.users","btn.addUser"],"actions":[{"key":"btn.inviteUser","endpoint":"/users/invite","type":"api","method":"POST"}]},{"key":"SCHEDULE","path":"/schedule","allowedRoles":["staff","manager"],"components":["page.container","page.title","calendar-container"],"actions":[{"key":"btn.createShift","endpoint":"/shifts","type":"api","method":"POST"}]},{"key":"LEADS","path":"/leads","allowedRoles":["staff","manager"],"components":["page.container","page.title","tbl.leads"],"actions":[{"key":"btn.createLead","endpoint":"/leads","type":"api","method":"POST"}]},{"key":"SETTINGS","path":"/settings","allowedRoles":["staff"],"components":["page.container","page.title","form.settings"],"actions":[{"key":"btn.saveSettings","endpoint":"/settings","type":"api","method":"PATCH","integrity":"guard.unsaved"}]},{"key":"MANAGER_DASHBOARD","path":"/manager/dashboard","allowedRoles":["manager"],"components":["page.container","page.title","mgr-dashboard"],"actions":[{"key":"btn.dailyEntry","target":"/manager/daily-entry","type":"route"}]},{"key":"MANAGER_DAILY_ENTRY","path":"/manager/daily-entry","allowedRoles":["manager"],"components":["page.container","page.title","form.daily.page"],"actions":[{"key":"btn.submitFinal","endpoint":"/daily-entry/submit","type":"api","method":"POST","integrity":"guard.unsaved"}]},{"key":"PSW_SHIFTS","path":"/shifts","allowedRoles":["psw"],"components":["page.container","page.title","tbl.shift-history"],"actions":[]},{"key":"CLIENT_BOOKINGS","path":"/bookings","allowedRoles":["client"],"components":["page.container","page.title","tbl.bookings"],"actions":[{"key":"btn.requestBooking","endpoint":"/bookings","type":"api","method":"POST"}]},{"key":"PROFILE","path":"/profile","allowedRoles":["staff","manager","psw","client"],"components":["page.container","page.title","form.profile.page"],"actions":[{"key":"btn.saveProfile","endpoint":"/profile","type":"api","method":"PATCH","integrity":"guard.unsaved"}]},{"key":"HOME","path":"/","allowedRoles":["guest","any"],"components":["page.container","hero","ctaBookNow"],"actions":[{"key":"btn.bookNow","target":"/book-now","type":"route"},{"key":"btn.viewServices","target":"/services","type":"route"}]}],"globalComponents":["nav.main","toast.success","toast.error","state.loading"],"integrityRules":{"form":["guard.unsaved.dialog","guard.unsaved.leave","guard.unsaved.stay"]}};

    cfg.pages.filter(p => p.actions.length > 0).forEach((page: any) => {
        describe(`Page Actions: ${page.key}`, () => {
            beforeEach(() => {
                cy.loginAs(page.allowedRoles[0]);
                cy.visitRoute("ADMIN_BASE_URL", page.path);
            });

            page.actions.forEach((action: any) => {
                it(`Action: ${action.key} triggers correct behavior`, () => {
                    if (action.type === "api") {
                        cy.intercept(action.method, "**" + action.endpoint + "**").as("apiCall");
                        cy.getByCy(action.key).click();
                        cy.wait("@apiCall");
                        cy.getByCy("toast.success").should("be.visible");
                    } else if (action.type === "route") {
                        cy.getByCy(action.key).click();
                        cy.url().should("include", action.target);
                    }
                });
            });
        });
    });
});
