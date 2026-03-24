const fs = require('fs');
const path = require('path');

const publicDir = path.join(__dirname, '..', 'apps', 'web-admin', 'public', 'knowledge-base');
const docsDir = path.join(__dirname, '..', 'docs', 'knowledge-base');

const ALL_ROLES = [
    "super_admin", "admin", "staff", "manager", "marketing_manager",
    "operations_manager", "hr_manager", "clinical_manager", "regional_manager",
    "finance_manager", "recruiting_manager", "coordinator", "client",
    "psw", "rn", "rmt", "rpt", "rch", "finance"
];

const roleSpecificData = {
    "super_admin": { desc: "The absolute architect and governor of the platform.", tasks: ["Provisioning new root tenants", "Monitoring Risk"], missing: ["Global Financial Meta-Home"] },
    "admin": { desc: "The Master Franchise Owner.", tasks: ["Branding", "Spawning Sub-Agencies"], missing: ["EDI/HL7 ingestion pipeline"] },
    "regional_manager": { desc: "Operations leader managing a cluster of Child Agencies.", tasks: ["Monitoring regional shift fulfillment rates"], missing: ["Inter-tenant load balancing UI"] },
    "operations_manager": { desc: "The heartbeat of a Child Agency.", tasks: ["Monitoring daily Auto-Pilot logs"], missing: ["Real-time SLA alerting home"] },
    "hr_manager": { desc: "The compliance gatekeeper.", tasks: ["Reviewing uploads", "Verify nurses"], missing: ["Automated OCR"] },
    "clinical_manager": { desc: "Ensures the quality of care.", tasks: ["Reviewing ADL logs", "Auditing notes"], missing: ["AI Summarization tool"] },
    "finance_manager": { desc: "Controls the margins and cash flow.", tasks: ["Reviewing Timesheets", "Approving Settlements"], missing: ["Dispute Resolution UI"] },
    "marketing_manager": { desc: "Generates B2B leads.", tasks: ["Running recruitment campaigns"], missing: ["Native marketing automation hub"] },
    "recruiting_manager": { desc: "Brings new providers into the ecosystem.", tasks: ["Calling potential RNs/PSWs"], missing: ["Provider Kanban board"] },
    "manager": { desc: "A generic middle-management role.", tasks: ["Managing team schedules"], missing: ["Customizable home widgets"] },
    "coordinator": { desc: "The edge-case handler.", tasks: ["Manually overriding shifts"], missing: ["Dynamic Surge Pricing UI"] },
    "staff": { desc: "Internal office worker.", tasks: ["Inputting basic client profiles"], missing: ["Integrated VoIP softphone"] },
    "finance": { desc: "Clerk-level financial processing.", tasks: ["Reconciling ledgers"], missing: ["QuickBooks Online two-way sync"] },
    "client": { desc: "The end-receiver of care.", tasks: ["Ordering new Bookings"], missing: ["Institutional Bulk Ordering UI"] },
    "rn": { desc: "Registered Nurse.", tasks: ["Accepting Auto-Pilot shifts"], missing: ["Native iOS App"] },
    "psw": { desc: "Personal Support Worker.", tasks: ["Accepting shifts"], missing: ["In-app digital W3C credential wallet"] },
    "rmt": { desc: "Registered Massage Therapist.", tasks: ["Performing therapeutic sessions"], missing: ["Visual anatomical charting UI"] },
    "rpt": { desc: "Registered Physiotherapist.", tasks: ["Setting post-op care plans"], missing: ["Wearable device API integration"] },
    "rch": { desc: "Registered Community Health worker.", tasks: ["Conducting home-safety evaluations"], missing: ["Community resource database integration"] }
};

for (const role of ALL_ROLES) {
    const data = roleSpecificData[role] || {
        desc: "A core role within the PrimeCare architecture.",
        tasks: ["System interaction"],
        missing: ["Role-specific specialized homes"]
    };

    const taskList = data.tasks.map(t => "*   Executing Task: " + t).join('\n');
    const missingList = data.missing.map(m => "*   Missing Feature: " + m).join('\n');

    const content = "# Role Playbook: " + role.toUpperCase() + "\n\n" +
        "## 1. The Persona & Purpose\n" +
        "The role within the PrimeCare Fractal SaaS ecosystem is defined as:\n\n" +
        data.desc + "\n\n" +
        "This role is protected by Role-Based Access Control (RBAC) middleware.\n\n" +
        "## 2. Core Operational Tasks\n" +
        "They execute the following core paths:\n\n" +
        taskList + "\n\n" +
        "## 3. The Day-in-the-Life Workflow\n" +
        "1. **Authentication:** The user logs in securely.\n" +
        "2. **Home Rendering:** They are redirected to their specialized home.\n" +
        "3. **Execution:** They interact with the PrimeCare modules.\n" +
        "4. **Data Persistence:** Every action is logged into the AuditLog table.\n\n" +
        "## 4. Gap Analysis: What is Missing?\n" +
        missingList + "\n\n" +
        "---\n_This document is automatically generated._\n";

    const filename = "role-" + role.replace(/_/g, '-') + ".md";
    const publicFilePath = path.join(publicDir, filename);
    const docsFilePath = path.join(docsDir, filename);

    fs.writeFileSync(publicFilePath, content);
    fs.writeFileSync(docsFilePath, content);
    console.log("Wrote exactly 1 file: " + filename);
}
