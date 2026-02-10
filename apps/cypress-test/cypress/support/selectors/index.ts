import { ADMIN_AUTH } from "./admin/auth.cy";
import { ADMIN_DASH } from "./admin/dashboard.cy";
import { ADMIN_USERS } from "./admin/users.cy";
import { ADMIN_SERVICES } from "./admin/services.cy";
import { ADMIN_OPS } from "./admin/operations.cy";

import { MGR_DASH } from "./manager/dashboard.cy";
import { MGR_DAILY } from "./manager/daily-entry.cy";
import { MGR_LEADS } from "./manager/leads.cy";

import { CLIENT_DASH } from "./client/dashboard.cy";
import { CLIENT_BOOKINGS } from "./client/bookings.cy";
import { CLIENT_BILLING } from "./client/billing.cy";

import { PSW_DASH } from "./psw/dashboard.cy";
import { PSW_SHIFTS } from "./psw/shifts.cy";
import { PSW_EARN } from "./psw/earnings.cy";

import { MKT_LAYOUT } from "./marketing/layout.cy";
import { MKT_LANDING } from "./marketing/landing.cy";
import { MKT_PAGES } from "./marketing/pages.cy";

export const COMMON = {
    sidebar: "sidebar",
    topbar: "topbar",
    toast: "toast",
    globalLoader: "global-loader",
    quickActions: "quick-actions",
    logoutBtn: "btn-logout",
    qaDailyEntry: "qa-daily-entry",
    qaAddClient: "qa-add-client",
    qaBar: "qa-bar",
};

export const SELECTORS = {
    ADMIN: {
        AUTH: ADMIN_AUTH,
        DASHBOARD: ADMIN_DASH,
        USERS: ADMIN_USERS,
        SERVICES: ADMIN_SERVICES,
        OPERATIONS: ADMIN_OPS,
    },
    MANAGER: {
        DASHBOARD: MGR_DASH,
        DAILY_ENTRY: MGR_DAILY,
        LEADS: MGR_LEADS,
    },
    CLIENT: {
        DASHBOARD: CLIENT_DASH,
        BOOKINGS: CLIENT_BOOKINGS,
        BILLING: CLIENT_BILLING,
    },
    PSW: {
        DASHBOARD: PSW_DASH,
        SHIFTS: PSW_SHIFTS,
        EARNINGS: PSW_EARN,
    },
    MARKETING: {
        LAYOUT: MKT_LAYOUT,
        LANDING: MKT_LANDING,
        PAGES: MKT_PAGES,
    },
    COMMON,
};

export default SELECTORS;
