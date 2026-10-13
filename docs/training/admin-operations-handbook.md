# PrimeCare Administrator Operations Handbook

Version 1.1 | 13 October 2026 | Audience: platform administrators, administrative assistants and their supervisors

## 1. Purpose and authority

Use this handbook to perform approved administrative work, report outcomes to management and train new staff. It describes the current TypeScript administration console and shared authenticated workspace. The new skeleton provides common authentication, layout, theme, localization and reporting components. A shared structure does not mean every historical screen has a complete business workflow.

The current governance role named `admin` is Administrative Assistant. The distinct `platform_admin` role is Platform Administrator. Do not use historical generated playbooks that identify `admin` as a franchise owner to decide access. Actual access comes from the current role, tenant, server permissions and authorized task catalog.

| Role | Responsibility | Boundary |
| --- | --- | --- |
| Platform Administrator | Provision tenants; manage tenant accounts and reference records; review administration audit; prepare authorized platform reports | No clinical records or billing transactions in this console; cannot grant platform_admin or modify protected platform/self accounts |
| Administrative Assistant | Work through assigned tenant workspace screens, tasks and reports; coordinate approved work and escalate access gaps | A visible requirement, inventory row or training lesson does not grant platform administration or make an unfinished workflow operational |
| Supervisor / manager | Approve work and priorities, verify recipient authority, review results, observe practical training and authorize independent duties | Supervisor responsibility does not automatically grant a technical system role |
| CEO / other authorized reporting role | Use reports that the server catalog permits for that account | Organization summary requires its separate grant and organization permission; do not assume every admin has it |

Before each change, confirm the approval, correct tenant, intended record and assigned authority. Use your own account. Never share a colleague's credentials or use browser edits to bypass a denial.

## 2. Daily duties and handover

### Start of day

1. Sign in to the appropriate portal with your own account. Platform administrators are directed to Platform Administration; other roles use their assigned workspace.
2. Confirm your role and tenant context. In the platform console, choose a tenant before opening Accounts, Master records or Audit.
3. Review assigned tasks and the supervisor's approved priorities. Use the workspace's authorized screens and available activity information.
4. Identify urgent access issues, unavailable workflows and unresolved work from the previous handover. Allocate an owner and due date in the organization's approved work log.
5. Use available data as evidence. An empty result, an unavailable metric and an actual zero are different findings.

### During the day

Check approval and tenant scope before each mutation. Submit once, confirm the returned result and review audit evidence when available. Record the outcome in the approved team log. Keep credentials and patient details out of general administration notes.

If the interface shows a pending or unavailable task, do not describe it as completed. Report the missing workflow or access dependency. Platform lists are bounded to 100 rows; search indexes currently loaded authorized information and is not a global database search.

### End of day

Prepare a brief handover: completed work, unresolved issues, impact, owner, due date, evidence location and decisions needed. State whether each outcome is confirmed, pending verification or blocked. Sign out on shared devices. The recommended cadence here is an operating procedure; the application does not create a recurring daily or weekly management report automatically.

## 3. Platform administrator procedures

### A. Provision a tenant

Approval required: the organization's approved name, slug and request owner.

Open Create tenant. Enter the approved name and a unique lowercase slug. The interface enforces a name length of up to 150 characters and a slug of 3-63 lowercase letters, digits or hyphens beginning with a letter. Submit once. Confirm the tenant appears and is selected before managing related records. Record the tenant reference, request owner and outcome.

If the outcome is unclear after a timeout, inspect the tenant list and available audit evidence before retrying the same values. The existing mutation contract binds idempotency keys to requests; changing values during an uncertain retry may create a different request. Escalate an unresolved outcome instead of creating repeated tenants.

### B. Create an account

Select the approved tenant and open Accounts. Verify the person's email, approved role and work requirement. Choose only a role the server provides. Initial passwords must satisfy the interface and server validation, including the current 12-72 character length. Use the organization's approved secure credential handover process; do not email a password as a management report or paste it into a training summary.

Submit once and confirm the account appears with the intended role and tenant. Notify the account owner through the approved channel. Record the access approval reference and result without storing the password.

### C. Change role or status

Confirm the request, target account and selected tenant. Review the intended role or active/inactive status. Save the change. The system revokes the target user's sessions when role or status changes. Explain that the user may need to sign in again after a permitted change. Confirm the result and available audit evidence.

This console cannot promote an account to platform_admin and cannot modify protected platform accounts or the actor's own account. Platform provisioning follows the separate protected bootstrap process, outside ordinary account maintenance.

### D. Maintain reference data

Open Master records for the selected tenant. Choose a supported type: location, department or service_category. Confirm the approved code and display label. Codes use the current governed lowercase format, 2-64 characters; labels are limited to 150 characters. Create or update only approved records.

Use inactive status to retire reference records rather than deleting their history. Updates require the current record version. If a conflict appears, refresh, inspect the latest record and reapply only the still-approved change. Do not overwrite another person's change blindly.

### E. Review audit and escalate

Open Audit after selecting the tenant. Compare the available action and timestamp with the approved work log. The present bounded view is not a complete forensic investigation interface. For unexpected access or changes, follow the organization's incident process and contact the designated supervisor or security owner promptly.

A useful escalation includes: observed fact, time, affected tenant reference, impact, immediate action taken, evidence location, owner and decision needed. Separate confirmed facts from assumptions. Avoid putting passwords, session tokens, clinical details or unnecessary account directories in routine management messages.

## 4. How to report to bosses

Management needs decisions and exceptions, supported by evidence. An activity list alone does not explain impact. The manager's name and reporting line must come from the organization; the application does not infer who your boss is.

| Cadence | Content | Supervisor action |
| --- | --- | --- |
| Daily handover | Completed requests, open issues, access problems, owner and next step | Set priorities and resolve blockers |
| Weekly review | Work totals supported by authorized reports, important changes, risks, overdue work and decisions required | Approve actions, resources or escalation |
| Monthly review | Access review, inactive reference records, recurring incidents, training review and unresolved workflow gaps | Review controls and staff readiness |
| Urgent exception | Observed incident, impact, time, immediate action and evidence reference | Follow the organization's escalation process immediately |

These are recommended review practices, not automated schedules or prescribed service-level deadlines. Your supervisor sets the actual cadence and escalation targets.

### Build the report package

1. Open Reports on your authorized reporting surface. Use the report selector returned by the server; different roles may receive different reports and capabilities.
2. Choose the report language. Apply supported filters and readiness options. Do not assume selecting a tenant elsewhere overrides a report's own server-defined scope.
3. Generate the report. Read the title, classification, scope and generation time. Verify that it covers the management question and intended reporting period. If the report has no date filter, explain that its timestamp is a point-in-time snapshot.
4. Review the preview. It shows at most 50 rows; the generated PDF contains the full bounded report, subject to the shared 1,000-row report limit. Explain any limitations rather than calling a preview complete.
5. Download the PDF when export is permitted. Check that the file opens and has the intended scope. Save it using the organization's approved naming and retention practice.
6. Add the cover note below. Separate figures from observations and proposed actions. Do not invent totals or readiness claims.
7. Verify the manager's exact email address and authority to receive this classification of information. External recipients require the same sharing check.
8. If email is permitted, enter the recipient, subject and short plain-text cover note, confirm sharing authority and send once. The message field is limited to 1,000 characters and subject to 150; use a concise summary.
9. Record the response. Provider acceptance means the mail service accepted the request; it does not confirm arrival in the manager's inbox. An unknown outcome stays blocked pending investigation. Do not repeatedly send a new request to resolve uncertainty.
10. Obtain management acknowledgement and track each agreed action, owner and due date in the approved work log. A sent report does not itself prove a management decision or completed action.

Changing the report, filters or language invalidates the previous preview and consent. Changing recipient or message also invalidates consent. Generate and review the new report, then confirm again.

### Management cover-note template

Reporting period / snapshot:
Prepared by / role:
Tenant or report scope:
Report title, generation time and classification:

Results: [confirmed work and evidence]
Exceptions: [open issue and impact]
Actions: [action, responsible owner and due date]
Decision requested: [specific approval or direction]
Limitations: [bounded results, unavailable data or unverified outcome]
Attachments / evidence location: [authorized reference]
Delivery status / acknowledgement: [accepted, confirmed by recipient, unknown or blocked]

Keep account passwords and patient information out of this template. Do not claim that the system has a verified reporting hierarchy, scheduled distribution, task approval engine or inbox tracking when those capabilities are not implemented.

## 5. Appearance and screen text

Appearance controls change the device presentation, such as theme and layout. Screen text contains English, French and Spanish catalogs. Local saves update the device copy without rebuilding the app; local history supports restore. Download is an explicit action that replaces the saved copy with current server text after confirmation.

These settings do not change business permissions, database rules or other users' devices. Exported JSON represents the selected screen text, not a business-data backup. Use the supported interface rather than editing an application bundle.

## 6. In-app training

On the websites, platform administrators open Training from the platform sidebar. Authenticated workspace users open Training from the top bar. Workspace access to educational material does not grant platform administration. Native app users open Training from Account or the school icon in an authorized workspace toolbar. The verified account ID scopes progress; signing out or switching accounts hides the previous account’s controls. The training includes eight lessons:

1. Role and safe access.
2. Daily work and handover.
3. Tenant provisioning.
4. Account and access changes.
5. Reference data quality.
6. Audit and escalation.
7. Reporting to management.
8. Presentation and training review.

Read each procedure and discuss its practice task with your supervisor. Select an answer and check it. Incorrect answers do not pass the lesson. Correct answers are saved on this device under the current account, gateway and course version. English, French and Spanish use the same lesson and answer definitions.

You can change lesson language, resume saved progress, download a JSON training summary on the website or save/share a PDF summary from the native app. You can also reset your device results. A storage failure is reported and does not record that attempt. Clearing browser data, using another device or another course version does not carry progress forward. No central employee training database, assignment workflow or certification is created by this module.

The downloadable summary is explicitly a device self-assessment with supervisorVerified set to false. It contains lesson identifiers and pass times, not credentials, patient data or operational records. Anyone with device access can alter local records, so it must not be treated as independent proof of competence. Send it through an approved channel for supervisor review.

## 7. Supervisor practical assessment

Use only a supervisor-approved training tenant and synthetic information. The lessons do not create accounts, alter records or send email automatically. A real mutation or email performed for practice still needs normal organizational authorization.

| Practical task | Observable evidence |
| --- | --- |
| Safe sign-in and sign-out | Learner identifies their role and scope and signs out correctly |
| Daily handover | One completed item, one issue, an owner, due date and decision request |
| Tenant procedure | Learner explains approval, slug, selection and uncertain-outcome handling |
| Account procedure | Learner explains approved role, secure credential handling and session revocation |
| Master data | Learner explains inactive status and stale-version review |
| Escalation | Learner distinguishes fact from assumption and supplies an approved evidence reference |
| Report package | Correct scope and classification, reviewed PDF, cover note and verified recipient |
| Device presentation | Learner explains local text versus server download and unchanged permissions |

Review platform-only tasks as explanations for assistants who lack that authority; do not ask them to bypass access. Record the learner, course version, observed tasks, supervisor, review date, gaps and next review in the organization's existing approved staff record. That supervisor record is separate from the current local training summary.

Approve independent duties only after the organization's practical and access requirements are satisfied. Passing a knowledge check is not a permission change or formal qualification.

## 8. Common problems and next action

| Finding | Next action |
| --- | --- |
| Access denied | Check role, tenant and approved task; ask the authorized owner to review access |
| Required workflow unavailable | Record the dependency and escalate; do not mark the business task complete |
| Mutation outcome unclear | Check current records and audit; preserve the original request scope before retry |
| Master version conflict | Refresh and review the latest record before applying an approved change |
| Report too broad or missing required data | Choose a permitted narrower report or escalate the limitation |
| Email accepted | Track acceptance; seek recipient acknowledgement when needed |
| Email outcome unknown | Investigate existing delivery evidence; do not automatically resend |
| Progress cannot save | Check browser/device storage; keep the attempt unrecorded until a successful save |
| New device or cleared browser storage | Repeat the local self-assessment or use the supervisor's separate staff record |

## 9. Implementation reference and readiness

Reviewed source baseline: merged commit 586af8133b96118cacd6feb4345b16fa47152f0c plus the native training change in PR200. Training course version: 2026-10-13.1.

Authority and workflow references: scripts/register-platform-admin-role.py; websites/typescript/src/platform-admin.ts; cloudflare/workers/src/platform-administration.ts; websites/typescript/src/reports.ts; cloudflare/workers/src/reporting.ts; scripts/register-admin-reports.py; websites/typescript/src/screen-text.ts; docs/architecture/admin-website-workflows.md; docs/architecture/admin-reporting.md.

Training is implemented as a shared TypeScript module with a governance-derived course and device-local controller. It is available in the responsive website, including mobile browsers. Native Flutter users open Training from Account or the authorized workspace toolbar. The same course is available with local app progress and a save/share PDF summary. Native app preferences and TypeScript browser storage do not synchronize automatically. Central completion tracking, course assignments and supervisor approval workflow remain separate future work.

Legacy inventory readiness, business API coverage, verified mail delivery and formal accessibility certification retain their own evidence requirements. This handbook does not mark all historical admin screens or all business workflows complete.
