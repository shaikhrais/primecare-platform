export const CLINICAL_ACCESS_CASES = [
    // Clinical (RN)
    {
        name: "Create care plan",
        method: "POST",
        url: "/v1/client/demo-client/care-plan",
        body: { goals: ["Improve mobility"], precautions: ["Fall risk"], interventions: ["ROM daily"] },
        allowedRoles: ["admin", "rn"],
    },
    {
        name: "Review daily entry",
        method: "POST",
        url: "/v1/daily-entry/demo-entry/review",
        body: { status: "APPROVED", notes: "Reviewed by RN" },
        allowedRoles: ["admin", "rn"],
    },

    // Admin & Ops
    {
        name: "Client Admission",
        method: "POST",
        url: "/v1/admin/clients",
        body: { fullName: "Test Client", email: "test@client.com", phone: "555-0199", address: "123 Main St" },
        allowedRoles: ["admin", "manager"],
    },
    {
        name: "PSW Onboarding",
        method: "POST",
        url: "/v1/admin/psw/onboard",
        body: { fullName: "Test PSW", email: "test@psw.com", phone: "555-0188", address: "456 Side St" },
        allowedRoles: ["admin", "manager"],
    },
    {
        name: "View Audit Logs",
        method: "GET",
        url: "/v1/admin/audit",
        allowedRoles: ["admin"],
    },
    {
        name: "Create Backup",
        method: "POST",
        url: "/v1/admin/backups",
        allowedRoles: ["admin"],
    },

    // Scheduling
    {
        name: "Create Visit",
        method: "POST",
        url: "/v1/admin/visits",
        body: { clientId: "demo-client", serviceId: "service-1", scheduledStart: new Date().toISOString() },
        allowedRoles: ["admin", "manager", "staff"],
    }
];
