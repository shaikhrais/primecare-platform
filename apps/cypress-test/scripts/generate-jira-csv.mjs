import fs from "fs";
import path from "path";

const root = process.cwd();
const registryDir = path.join(root, "cypress", "fixtures", "registry");
const outPath = path.join(root, "cypress", "docs", "jira_test_export.csv");

function readJson(file) {
    return JSON.parse(fs.readFileSync(path.join(registryDir, file), "utf8"));
}

const marketing = readJson("routes.marketing.json");
const admin = readJson("routes.admin.json");

const header = "Issue Type,Summary,Description,Precondition,Test Steps,Test Data,Expected Result,Priority,Component/s,Labels,Affects Version,Fix Version/s";

const rows = [];

// 1. Marketing Routes (14)
marketing.routes.forEach(r => {
    rows.push([
        "Test",
        `SMOKE - Marketing ${r.key} loads`,
        `Verify marketing ${r.key} page loads without errors`,
        "Marketing site deployed",
        `1. Open MARKETING_BASE_URL + '${r.path}'\n2. Confirm no crash`,
        `URL: ${r.path}`,
        "Page renders successfully",
        "High",
        "Marketing",
        "@smoke @marketing",
        "1.4.3",
        ""
    ]);
});

// 2. Admin/Manager/Portal Routes (22)
admin.routes.forEach(r => {
    const isGuest = r.auth === "guest" || r.auth === "any";
    rows.push([
        "Test",
        `SMOKE - Admin ${r.key} access`,
        `Verify ${r.key} page ${isGuest ? 'loads' : 'redirects'} for guest`,
        "Admin site deployed",
        `1. Open ADMIN_BASE_URL + '${r.path}'\n2. Verify ${isGuest ? 'no crash' : 'login redirect'}`,
        `URL: ${r.path}`,
        isGuest ? "Page renders" : "Redirects to /login",
        "Highest",
        "Security",
        "@smoke @security",
        "1.4.3",
        ""
    ]);
});

// 3. Essential Scenarios to reach 51 (15 more)
const scenarios = [
    ["AUTH", "Invalid Password", "Verify login fails with wrong password", "Valid user exists", "1. Try login with wrong password", "Valid email, wrong pass", "Error message shown", "Highest", "Auth", "@auth @negative"],
    ["AUTH", "Forgot Password", "Verify recovery request flow", "Valid email", "1. Submit forgot password", "Valid email", "Success message", "High", "Auth", "@auth"],
    ["RBAC", "PSW block Users", "Verify PSW cannot access /users", "Logged in as PSW", "1. Visit /users", "PSW role", "Redirect to Login/Denied", "Highest", "Security", "@rbac @psw"],
    ["RBAC", "Client block Users", "Verify Client cannot access /users", "Logged in as Client", "1. Visit /users", "Client role", "Redirect to Login/Denied", "Highest", "Security", "@rbac @client"],
    ["RBAC", "Manager access Daily", "Verify Manager can access daily checkins", "Logged in as Manager", "1. Visit /manager/daily-entry", "Manager role", "Dashboard loads", "High", "Manager", "@rbac @manager"],
    ["STATE", "Dashboard Empty", "Verify dashboard handles empty data state", "Logged in as Staff; No data in API", "1. Visit /dashboard", "Empty API stub", "Shows empty state UI", "Medium", "Admin", "@state"],
    ["STATE", "Dashboard Error 500", "Verify dashboard handles API failure", "Logged in as Staff; API 500s", "1. Visit /dashboard", "API 500 stub", "Shows error fallback UI", "Medium", "Admin", "@state"],
    ["CONTRACT", "Users Table", "Verify users table schema and visibility", "Logged in as Staff", "1. Visit /users", "N/A", "Table correctly rendered", "High", "Contract", "@contract"],
    ["CONTRACT", "Schedule Calendar", "Verify calendar render contract", "Logged in as Staff", "1. Visit /schedule", "N/A", "Calendar visible", "High", "Contract", "@contract"],
    ["CONTRACT", "Leads Form", "Verify leads form fields exist", "Logged in as Staff", "1. Visit /leads", "N/A", "Form inputs visible", "High", "Contract", "@contract"],
    ["PERF", "Lighthouse Home", "Verify marketing home performance score", "Marketing deployed", "1. Run lighthouse audit on /", "N/A", "Score > 90", "Medium", "Marketing", "@performance"],
    ["WAF", "SQL Injection", "Verify auth inputs resist SQLi", "Login page accessible", "1. Submit ' OR 1=1 -- in email", "Payload: SQLi", "Rejected/Auth failed", "Highest", "Security", "@security"],
    ["WAF", "XSS Header", "Verify search params resist XSS", "Search pages accessible", "1. Insert <script> in search", "Payload: XSS", "Sanitized/Escaped", "Highest", "Security", "@security"],
    ["WAF", "No-Sniff Header", "Verify security headers present", "Any page", "1. Check response headers", "N/A", "X-Content-Type-Options: nosniff present", "Medium", "Security", "@security"],
    ["ROUTING", "404 Generic", "Verify fallback for non-existent paths", "Admin deployed", "1. Visit /invalid-page", "N/A", "404 or Redirect shown", "Medium", "Routing", "@routing"]
];

scenarios.forEach(s => {
    rows.push([
        "Test",
        `${s[0]} - ${s[1]}`,
        s[2],
        s[3],
        s[4],
        s[5],
        s[6],
        s[7],
        s[8],
        s[9],
        "1.4.3",
        ""
    ]);
});

const csvContent = header + "\n" + rows.map(r => r.map(c => `"${c.replace(/"/g, '""')}"`).join(",")).join("\n");

fs.writeFileSync(outPath, csvContent, "utf8");
console.log(`Generated ${rows.length} test cases in ${outPath}`);
