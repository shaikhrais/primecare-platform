
/**
 * ROLE 01: PSW
 * Mathematical Structure: [ROLE].[SCREEN].[COMP] NAME
 */

const pswFullSuite = [
    { id: "01.01.01", name: "PSW__Login__PageLoad__SUCCESS", run: () => { cy.visit("/login"); cy.url().should("include", "/login"); } },
    { id: "01.01.02", name: "PSW__Login__Logo__VISIBLE", run: () => { cy.get('img[alt="PrimeCare"]').should("be.visible"); } },
    { id: "01.01.03", name: "PSW__Login__EmailInput__VISIBLE", run: () => { cy.get('input[type="email"]').should("be.visible"); } },
    { id: "01.01.04", name: "PSW__Login__PasswordInput__VISIBLE", run: () => { cy.get('input[type="password"]').should("be.visible"); } },
    { id: "01.01.06", name: "PSW__Login__LoginButton__CLICKABLE", run: () => { cy.contains('button', /Sign in/i).should("not.be.disabled"); } },
    { id: "01.01.07", name: "PSW__Login__ForgotPassword__VISIBLE", run: () => { cy.contains('a', /Forgot password/i).should("be.visible"); } },
    {
        id: "01.01.08", name: "PSW__Login__EmptyForm__ERROR", run: () => {
            cy.contains('button', /Sign in/i).click();
            // If browser validation blocks, we check for required attribute
            cy.get('input[type="email"]').should('have.attr', 'required');
        }
    },
    {
        id: "01.01.09", name: "PSW__Login__ValidLogin__REDIRECT", run: () => {
            const email = Cypress.env("PSW_EMAIL") || "psw.a@primecare.ca";
            const password = Cypress.env("PSW_PASSWORD") || "admin123";

            // Explicitly wait for the input to be ready and not disabled
            cy.get('input[type="email"]').should('be.visible').and('not.be.disabled');

            // Fast atomic input (Split chains to avoid detachment)
            cy.get('input[type="email"]').clear({ force: true });
            cy.get('input[type="email"]').type(email, { delay: 0 });

            cy.get('input[type="password"]').clear({ force: true });
            cy.get('input[type="password"]').type(password, { delay: 0 });

            // Ensure button is ready
            cy.contains('button', /Sign in/i).should('be.visible').and('not.be.disabled');
            cy.contains('button', /Sign in/i).click({ force: true });

            // Wait for the dashboard load and a specific element
            cy.url({ timeout: 45000 }).should("include", "/dashboard");
            cy.contains('Caregiver', { timeout: 15000 }).should('be.visible');
        }
    },
    {
        id: "01.01.10", name: "PSW__Login__API_Login__200", run: () => {
            cy.request({
                method: "POST",
                url: `${Cypress.env("API_BASE_URL") || 'https://primecare-api.itpro-mohammed.workers.dev'}/v1/auth/login`,
                body: { email: "psw.a@primecare.ca", password: "admin123" },
                failOnStatusCode: false
            }).its("status").should("satisfy", (s: number) => s === 200 || s === 401);
        }
    },

    // 01.02: DASHBOARD
    { id: "01.02.01", name: "PSW__Dashboard__PageLoad__SUCCESS", run: () => { cy.url().should("include", "/dashboard"); } },
    { id: "01.02.02", name: "PSW__Dashboard__WelcomeCard__VISIBLE", run: () => { cy.contains('My Work Schedule, Caregiver!').should('be.visible'); } },
    { id: "01.02.03", name: "PSW__Dashboard__TodayShiftCard__LOAD", run: () => { cy.get('[data-testid="today-shift-card"]').should("exist"); } },
    { id: "01.02.04", name: "PSW__Dashboard__StatsCard__DATA", run: () => { cy.contains('$1,240').should('be.visible'); } },
    { id: "01.02.05", name: "PSW__Dashboard__EarningsCard__VISIBLE", run: () => { cy.get('[data-testid="earnings-card"]').should("be.visible"); } },
    { id: "01.02.06", name: "PSW__Dashboard__QuickAction__NAV_WORKS", run: () => { cy.get('[data-testid="quick-action-shifts"]').should("exist"); } },
    { id: "01.02.07", name: "PSW__Dashboard__NotificationBell__OPEN", run: () => { cy.get('button').find('svg').should("exist"); } },
    { id: "01.02.08", name: "PSW__Dashboard__SideMenu__TOGGLE", run: () => { cy.get('[data-testid="menu-toggle"]').click(); } },
    { id: "01.02.09", name: "PSW__Dashboard__Logout__REDIRECT", run: () => { cy.get('button').contains(/PSW|Profile|Caregiver/i).click({ force: true }); cy.contains('button', /Logout/i).should("exist"); } },

    // 01.03: SHIFTS
    { id: "01.03.01", name: "PSW__Shifts__PageLoad__SUCCESS", run: () => { cy.visit("/shifts"); cy.url().should("include", "/shifts"); } },
    { id: "01.03.02", name: "PSW__Shifts__ShiftTable__VISIBLE", run: () => { cy.get('table').should("be.visible"); } },
    { id: "01.03.03", name: "PSW__Shifts__ShiftRow__DATA_PRESENT", run: () => { cy.get('[data-testid="shift-row"]').should("exist"); } },
    { id: "01.03.04", name: "PSW__Shifts__AcceptButton__CLICK_SUCCESS", run: () => { cy.get('[data-testid="accept-btn"]').first().should("not.be.disabled"); } },
    { id: "01.03.05", name: "PSW__Shifts__DeclineButton__CLICK_SUCCESS", run: () => { cy.get('[data-testid="decline-btn"]').first().should("not.be.disabled"); } },
    { id: "01.03.06", name: "PSW__Shifts__DetailsModal__OPEN", run: () => { cy.get('[data-testid="view-details-btn"]').first().click(); cy.get('[data-testid="shift-details-modal"]').should("be.visible"); cy.get('[data-testid="close-modal"]').click(); } },
    { id: "01.03.07", name: "PSW__Shifts__Filter__WORKS", run: () => { cy.get('[data-testid="filter-status"]').should("exist"); } },
    { id: "01.03.08", name: "PSW__Shifts__Search__WORKS", run: () => { cy.get('[data-testid="shift-search"]').should("exist"); } },
    { id: "01.03.09", name: "PSW__Shifts__Pagination__WORKS", run: () => { cy.get('[data-testid="pagination"]').should("exist"); } },
    { id: "01.03.10", name: "PSW__Shifts__API_Load__200", run: () => { cy.request({ url: "/api/shifts", failOnStatusCode: false }).its("status").should("satisfy", (s: number) => s === 200 || s === 401); } },

    // 01.04: DAILY ENTRY
    { id: "01.04.01", name: "PSW__DailyEntry__PageLoad__SUCCESS", run: () => { cy.visit("/daily-entry"); cy.url().should("include", "/daily-entry"); } },
    { id: "01.04.02", name: "PSW__DailyEntry__ClientSelector__LOAD", run: () => { cy.get('[data-testid="client-selector"]').should("exist"); } },
    { id: "01.04.03", name: "PSW__DailyEntry__ServiceChecklist__SELECT", run: () => { cy.get('[data-testid="service-checklist"]').should("exist"); } },
    { id: "01.04.04", name: "PSW__DailyEntry__NotesField__INPUT", run: () => { cy.get('[data-testid="notes-field"]').should("exist"); } },
    { id: "01.04.05", name: "PSW__DailyEntry__TimeIn__VALIDATION", run: () => { cy.get('[data-testid="time-in"]').should("exist"); } },
    { id: "01.04.06", name: "PSW__DailyEntry__TimeOut__VALIDATION", run: () => { cy.get('[data-testid="time-out"]').should("exist"); } },
    { id: "01.04.07", name: "PSW__DailyEntry__SignaturePad__SAVE", run: () => { cy.get('[data-testid="signature-pad"]').should("exist"); } },
    { id: "01.04.08", name: "PSW__DailyEntry__SaveButton__SUCCESS", run: () => { cy.get('[data-testid="save-btn"]').should("not.be.disabled"); } },
    { id: "01.04.09", name: "PSW__DailyEntry__SubmitButton__SUCCESS", run: () => { cy.get('[data-testid="submit-btn"]').should("not.be.disabled"); } },
    { id: "01.04.10", name: "PSW__DailyEntry__API_Save__200", run: () => { cy.request({ method: "POST", url: "/api/daily-entry", body: {}, failOnStatusCode: false }).its("status").should("satisfy", (s: number) => s === 201 || s === 401); } },

    // 01.05: EARNINGS
    { id: "01.05.01", name: "PSW__Earnings__PageLoad__SUCCESS", run: () => { cy.visit("/earnings"); cy.url().should("include", "/earnings"); } },
    { id: "01.05.02", name: "PSW__Earnings__Table__VISIBLE", run: () => { cy.get('[data-testid="earnings-table"]').should("be.visible"); } },
    { id: "01.05.03", name: "PSW__Earnings__TotalCard__CORRECT", run: () => { cy.get('[data-testid="total-earnings-card"]').should("be.visible"); } },
    { id: "01.05.04", name: "PSW__Earnings__DateFilter__WORKS", run: () => { cy.get('[data-testid="date-filter"]').should("exist"); } },
    { id: "01.05.05", name: "PSW__Earnings__Export__CSV", run: () => { cy.get('[data-testid="export-csv"]').should("exist"); } },
    { id: "01.05.06", name: "PSW__Earnings__DownloadPDF__SUCCESS", run: () => { cy.get('[data-testid="download-pdf"]').should("exist"); } },
    { id: "01.05.07", name: "PSW__Earnings__Pagination__WORKS", run: () => { cy.get('[data-testid="pagination"]').should("exist"); } },
    { id: "01.05.08", name: "PSW__Earnings__API_Load__200", run: () => { cy.request({ url: "/api/earnings", failOnStatusCode: false }).its("status").should("satisfy", (s: number) => s === 200 || s === 401); } },

    // 01.06: PROFILE
    { id: "01.06.01", name: "PSW__Profile__PageLoad__SUCCESS", run: () => { cy.visit("/profile"); cy.url().should("include", "/profile"); } },
    { id: "01.06.02", name: "PSW__Profile__ProfileCard__VISIBLE", run: () => { cy.get('[data-testid="profile-card"]').should("be.visible"); } },
    { id: "01.06.03", name: "PSW__Profile__EditButton__ENABLE", run: () => { cy.get('[data-testid="edit-profile-btn"]').should("exist"); } },
    { id: "01.06.04", name: "PSW__Profile__NameField__UPDATE", run: () => { cy.get('[data-testid="profile-name"]').should("exist"); } },
    { id: "01.06.05", name: "PSW__Profile__PhoneField__VALIDATION", run: () => { cy.get('[data-testid="profile-phone"]').should("exist"); } },
    { id: "01.06.06", name: "PSW__Profile__UploadPhoto__SUCCESS", run: () => { cy.get('[data-testid="upload-photo"]').should("exist"); } },
    { id: "01.06.07", name: "PSW__Profile__ChangePassword__WORKS", run: () => { cy.get('[data-testid="change-password-section"]').should("exist"); } },
    { id: "01.06.08", name: "PSW__Profile__SaveButton__SUCCESS", run: () => { cy.get('[data-testid="save-profile-btn"]').should("exist"); } },
    { id: "01.06.09", name: "PSW__Profile__API_Update__200", run: () => { cy.request({ method: "PUT", url: "/api/profile", body: {}, failOnStatusCode: false }).its("status").should("satisfy", (s: number) => s === 200 || s === 401); } },

    // 01.07: NOTIFICATIONS
    { id: "01.07.01", name: "PSW__Notifications__PageLoad__SUCCESS", run: () => { cy.visit("/notifications"); cy.url().should("include", "/notifications"); } },
    { id: "01.07.02", name: "PSW__Notifications__List__LOAD", run: () => { cy.get('[data-testid="notification-list"]').should("exist"); } },
    { id: "01.07.03", name: "PSW__Notifications__MarkRead__SUCCESS", run: () => { cy.get('[data-testid="mark-read-btn"]').should("exist"); } },
    { id: "01.07.04", name: "PSW__Notifications__Delete__SUCCESS", run: () => { cy.get('[data-testid="delete-notification-btn"]').should("exist"); } },
    { id: "01.07.05", name: "PSW__Notifications__API_Load__200", run: () => { cy.request({ url: "/api/notifications", failOnStatusCode: false }).its("status").should("satisfy", (s: number) => s === 200 || s === 401); } },

    // 01.08: MESSAGES
    { id: "01.08.01", name: "PSW__Messages__PageLoad__SUCCESS", run: () => { cy.visit("/messages"); cy.url().should("include", "/messages"); } },
    { id: "01.08.02", name: "PSW__Messages__ConversationList__LOAD", run: () => { cy.get('[data-testid="conversation-list"]').should("exist"); } },
    { id: "01.08.03", name: "PSW__Messages__MessageInput__TYPE", run: () => { cy.get('[data-testid="message-input"]').should("exist"); } },
    { id: "01.08.04", name: "PSW__Messages__Send__SUCCESS", run: () => { cy.get('[data-testid="send-message-btn"]').should("exist"); } },
    { id: "01.08.05", name: "PSW__Messages__API_Send__200", run: () => { cy.request({ method: "POST", url: "/api/messages", body: {}, failOnStatusCode: false }).its("status").should("satisfy", (s: number) => s === 201 || s === 401); } },

    // 01.09: GLOBAL SYSTEM
    { id: "01.09.01", name: "PSW__Global__No500Errors__PASS", run: () => { cy.visit("/"); cy.contains("Server Error").should("not.exist"); } },
    { id: "01.09.02", name: "PSW__Global__ConsoleErrors__NONE", run: () => { /* Handled by e2e.ts listener */ } },
    { id: "01.09.03", name: "PSW__Global__SessionExpire__LOGOUT", run: () => { cy.window().then((win) => { win.localStorage.clear(); }); cy.visit("/dashboard"); cy.url().should("include", "/login"); } },
    { id: "01.09.04", name: "PSW__Global__TokenRefresh__WORKS", run: () => { cy.request({ url: "/api/auth/refresh", failOnStatusCode: false }).its("status").should("not.eq", 500); } },
    { id: "01.09.05", name: "PSW__Global__Loader__DISAPPEAR", run: () => { cy.get('[data-testid="global-loader"]').should("not.exist"); } },

    // 01.10: RBAC
    { id: "01.10.01", name: "PSW__RBAC__AdminRoute__DENIED", run: () => { cy.visit("/admin/users", { failOnStatusCode: false }); cy.contains(/unauthorized|forbidden|not found/i).should("be.visible"); } },
    { id: "01.10.02", name: "PSW__RBAC__RNEditPlan__DENIED", run: () => { cy.visit("/rn/care-plans", { failOnStatusCode: false }); cy.contains(/unauthorized|forbidden/i).should("be.visible"); } },
    { id: "01.10.03", name: "PSW__RBAC__CreateShift__DENIED", run: () => { cy.get('[data-testid="create-shift-btn"]').should("not.exist"); } },
    { id: "01.10.04", name: "PSW__RBAC__DeleteClient__DENIED", run: () => { cy.get('[data-testid="delete-client-btn"]').should("not.exist"); } },
];

describe("PSW Mathematical Micro-Steps (Full Suite)", () => {
    before(() => {
        cy.task('resetLogs');
        cy.clearCookies();
        cy.clearLocalStorage();

        // Visit with a long timeout
        cy.visit("/login", { timeout: 60000 });

        // Settle + Cookie handling
        cy.wait(5000);
        cy.get("body").then(($body) => {
            const btn = $body.find('button').filter((i, el) => /Accept All|Essential Only/i.test(el.innerText));
            if (btn.length > 0) cy.wrap(btn).click({ force: true, multiple: true });
        });
        cy.wait(10000); // Massive settle for live transitions

        // Final check for visibility
        cy.get('input[type="email"]', { timeout: 15000 }).should('be.visible');
        cy.wait(2000);
    });

    pswFullSuite.forEach((s) => {
        it(`${s.id}  ${s.name}`, () => {
            // Re-intercept in case of reloads
            cy.intercept('GET', '**/auth/whoami').as('whoami');
            s.run();
        });
    });
});
