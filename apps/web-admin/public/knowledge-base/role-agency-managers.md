# Role Playbook: Child Agency Managers (Ops, HR, Clinical, Finance)

## The Persona
This is the operational leadership of the local Child Tenant. The schema breaks this down into granular functions: `operations_manager`, `hr_manager`, `clinical_manager`, `finance_manager`, and `recruiting_manager`. They run the day-to-day business.

## Core Responsibilities & Workflows
*   **Recruiting Manager:** Sources new nurses locally, guiding them to sign up on the portal.
*   **HR / Compliance Manager:** Reviews uploaded `PswDocument` files (licenses, TB tests). They execute the "Verify" command, which unlocks the nurse for algorithm matchmaking.
*   **Clinical Manager:** Reviews `DailyEntry` forms and ADL (Activities of Daily Living) data to ensure care quality.
*   **Finance Manager:** Reviews submitted `Timesheet` data and approves them for final Stripe Instant Settlement, managing the agency's margin spread.

## Day-in-the-Life Execution
The HR Manager logs in on a Monday morning. They have a queue of 15 pending document uploads from new nurses. They review the PDFs, checking expiration dates, and click "Approve" on 12 of them. These 12 nurses instantly become eligible for Auto-Pilot shifts. The Finance manager logs in on Friday to review disputed timesheets where a nurse's GPS check-out didn't match the hospital's reported hours.

## ⚠️ What is Currently Missing? (Gap Analysis)
*   **Automated OCR Verification:** HR Managers currently have to manually read the PDF uploads. We need to integrate an OCR tool (like Amazon Textract) to automatically read license dates and auto-verify documents.
*   **Granular RBAC UI Check:** While the backend has RBAC (Role-Based Access Control) defined, the frontend UI doesn't visually hide all irrelevant tabs perfectly for sub-manager roles yet. For instance, an HR Manager shouldn't see the Financial margin splits.
*   **Dispute Resolution Hub:** A dedicated UI interface for the Finance Manager to communicate with a hospital when a shift duration is disputed.