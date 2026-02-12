export const CLINICAL_ACCESS_CASES = [
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
    {
        name: "RN supervise PSW overview",
        method: "GET",
        url: "/v1/rn/psw/demo-psw/overview",
        allowedRoles: ["admin", "rn"],
    }
];
