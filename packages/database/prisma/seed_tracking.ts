import { PrismaClient } from '../generated/client';

const prisma = new PrismaClient();

const ROLES_AND_SCREENS = [
  {
    roleName: "psw",
    screens: [
      {
        orderIndex: 1,
        name: "PSW Live Visit",
        route: "/psw/live-visit",
        status: "completed",
        description: "The core operational environment for PSWs during an active shift. All EVV compliance and clinical checklists must be logged here to legally verify attendance and care delivery.",
        functions: [
          {
            orderIndex: 1,
            title: "Submit GPS EVV Data",
            isCore: true,
            status: "fully_tested",
            apiEndpoint: "POST /v1/activities/event",
            dataEntryFields: "visitId, lat, lng, deviceTimeIso",
            justification: "Core EVV compliance. Implemented natively with precise geolocation tracking."
          },
          {
            orderIndex: 2,
            title: "Submit ADL Checklist",
            isCore: true,
            status: "fully_tested",
            apiEndpoint: "POST /v1/activities/checklist",
            dataEntryFields: "visitId, checklist (JSON array)",
            justification: "Daily living tracking. Best implemented via a dynamic SDUI form fetched from the server."
          },
          {
             orderIndex: 3,
             title: "Report Critical Incident",
             isCore: true,
             status: "fully_tested",
             apiEndpoint: "POST /v1/psw/incidents",
             dataEntryFields: "visitId, severity, description, photoUrl",
             justification: "Allows PSWs to log falls or emergencies. Crucial for liability. Screen needs a red SOS floating action button that brings up a modal."
          },
          {
             orderIndex: 4,
             title: "View Active Care Plan",
             isCore: false,
             status: "fully_tested",
             apiEndpoint: "GET /v1/psw/care-plan/:patientId",
             dataEntryFields: "patientId",
             justification: "Read-only access to RN-authored instructions. Should be implemented as a bottom-up sliding panel so it doesn't navigate away from EVV."
          }
        ]
      },
      {
        orderIndex: 2,
        name: "PSW Universal Thin Hub",
        route: "/psw/home",
        status: "completed",
        description: "The primary landing page. Utilizes the 'Narrow Path' paradigm to prevent cognitive overload. It strictly provides the singular next best action for the user without complex scheduling calendars.",
        functions: [
          {
            orderIndex: 1,
            title: "Fetch Next Action",
            isCore: true,
            status: "fully_tested",
            apiEndpoint: "GET /v1/narrow-path/next-action?role=psw",
            dataEntryFields: "role query param",
            justification: "The Narrow Path UX paradigm. Reduces choice fatigue."
          },
          {
            orderIndex: 2,
            title: "Submit Timesheet / Availability",
            isCore: false,
            status: "fully_tested",
            apiEndpoint: "POST /v1/psw/availability",
            dataEntryFields: "dateRange, availableHours",
            justification: "Needed for scheduling. Should be implemented as a simple 2-week rolling toggle switch."
          },
          {
             orderIndex: 3,
             title: "View Historic Earnings",
             isCore: false,
             status: "fully_tested",
             apiEndpoint: "GET /v1/psw/earnings",
             dataEntryFields: "month",
             justification: "Increases retention when PSWs can transparently see their payout logic. Connected directly to the Ledger."
          }
        ]
      }
    ]
  },
  {
    roleName: "rn",
    screens: [
      {
        orderIndex: 1,
        name: "RN Patient List",
        route: "/rn/patients",
        status: "completed",
        description: "Clinical directory access. Narrows the platform down to only the patients assigned to this specific RN for strict HIPAA/PHIPA compartmentalization.",
        functions: [
          {
            orderIndex: 1,
            title: "View Assigned Patients",
            isCore: true,
            status: "wired_to_api",
            apiEndpoint: "GET /v1/rn/clinical/profiles",
            dataEntryFields: "None",
            justification: "Standard list view. Future iterations should add a 'Triage Score' colored indicator."
          },
          {
             orderIndex: 2,
             title: "Author New Care Plan",
             isCore: true,
             status: "fully_tested",
             apiEndpoint: "POST /v1/rn/clinical/care-plans",
             dataEntryFields: "patientId, frequency, instructions, adlList",
             justification: "The primary clinical duty. Needs a robust SDUI form builder so the RN can customize checklist requirements per patient."
          }
        ]
      },
      {
        orderIndex: 2,
        name: "RN Clinical Assessment",
        route: "/rn/assessment",
        status: "completed",
        description: "Clinical deep dive. Required for complex medication reconciliations and finalizing clinical sign-offs.",
        functions: [
          {
            orderIndex: 1,
            title: "Conduct Medication Recon",
            isCore: true,
            status: "fully_tested",
            apiEndpoint: "POST /v1/rn/clinical/med-recon",
            dataEntryFields: "patientId, medList, dosages",
            justification: "Requires OCR via camera in the Flutter app to automatically scan pill bottles to reduce RN typos."
          },
          {
             orderIndex: 2,
             title: "Sign-off on PSW Actions",
             isCore: true,
             status: "fully_tested",
             apiEndpoint: "PATCH /v1/activities/actions",
             dataEntryFields: "actionId, status",
             justification: "Core supervision loop. Narrow path allows bulk approvals."
          }
        ]
      }
    ]
  },
  {
    roleName: "coordinator",
    screens: [
      {
        orderIndex: 1,
        name: "Live Dispatch Board",
        route: "/coordinator/home",
        status: "completed",
        description: "The logistical nucleus of the agency. Empowers coordinators to resolve unassigned visits visually without algorithmic interference.",
        functions: [
          {
            orderIndex: 1,
            title: "Drag and Drop Visits",
            isCore: true,
            status: "wired_to_api",
            apiEndpoint: "POST /v1/activities/dispatch",
            dataEntryFields: "visitId, pswId, scheduledTime",
            justification: "Visual scheduling is required. Implement with Flutter's built-in LongPressDraggable for native fluidity."
          },
          {
            orderIndex: 2,
            title: "Process PSW Call-in (Sick)",
            isCore: true,
            status: "fully_tested",
            apiEndpoint: "POST /v1/coordinator/call-ins",
            dataEntryFields: "pswId, date, reasonCode",
            justification: "Immediate unassignment of all visits for that PSW. Instantly drops those visits back into the 'Unassigned' DLQ."
          },
          {
            orderIndex: 3,
            title: "Client Schedule Adjustment",
            isCore: false,
            status: "fully_tested",
            apiEndpoint: "PATCH /v1/coordinator/visits/:id",
            dataEntryFields: "visitId, newTime",
            justification: "For when clients request time changes. Needs a collision detection layer to warn if the PSW is busy."
          }
        ]
      }
    ]
  },
  {
    roleName: "manager",
    screens: [
      {
        orderIndex: 1,
        name: "Manager Dashboard",
        route: "/manager/home",
        status: "completed",
        description: "Administrative oversight terminal. Exists to convert logistical data into compliant legal exports and payroll approvals.",
        functions: [
          {
            orderIndex: 1,
            title: "Trigger Shift Roster Export",
            isCore: true,
            status: "fully_tested",
            apiEndpoint: "POST /v1/manager/reports/export",
            dataEntryFields: "type='density'",
            justification: "Used for external auditing formats. Connected directly to Cloudflare R2 bucket."
          },
          {
            orderIndex: 2,
            title: "Approve Weekly Payroll Batch",
            isCore: true,
            status: "fully_tested",
            apiEndpoint: "POST /v1/manager/payroll/approve",
            dataEntryFields: "batchId, overrideFlags",
            justification: "Finalizes the auto-generated timesheets. Unlocks the Ledger transactions to be officially commited."
          },
          {
            orderIndex: 3,
            title: "Review Incident Escalations",
            isCore: true,
            status: "fully_tested",
            apiEndpoint: "PATCH /v1/manager/incidents/:id",
            dataEntryFields: "incidentId, resolution, closeCase",
            justification: "Managers handle legal/safety fallouts. Needs a deep timeline view of all events surrounding the incident."
          }
        ]
      }
    ]
  },
  {
      roleName: "client",
      screens: [
          {
              orderIndex: 1,
              name: "Client Family Portal",
              route: "/client/home",
              status: "completed",
              description: "Transparency portal for the ultimate consumer. Alleviates agency phone traffic by exposing basic scheduling and billing independently to the family.",
              functions: [
                  {
                      orderIndex: 1,
                      title: "View Upcoming Schedule",
                      isCore: true,
                      status: "fully_tested",
                      apiEndpoint: "GET /v1/client/visits",
                      dataEntryFields: "month",
                      justification: "Families need peace of mind tracking when caregivers arrive. Connect to map for 'En Route' status."
                  },
                  {
                      orderIndex: 2,
                      title: "Pay Outstanding Invoices",
                      isCore: true,
                      status: "fully_tested",
                      apiEndpoint: "POST /v1/client/payments",
                      dataEntryFields: "invoiceId, StripeToken",
                      justification: "Direct integration via Stripe Elements so the agency gets paid faster."
                  },
                  {
                      orderIndex: 3,
                      title: "Message Care Team",
                      isCore: false,
                      status: "fully_tested",
                      apiEndpoint: "POST /v1/inbox/messages",
                      dataEntryFields: "body, recipientType='agency'",
                      justification: "Replaces noisy phone calls to the agency with asynchronous secure chat."
                  }
              ]
          }
      ]
  },
  {
    roleName: "gm",
    screens: [
      {
        orderIndex: 1,
        name: "GM Executive Hub",
        route: "/gm_home",
        status: "completed",
        description: "Macro-level business performance monitor. The GM needs global insight without granular noise. This screen distills the entire agency down to margin and risk.",
        functions: [
          {
            orderIndex: 1,
            title: "Authorize DB Payroll Patch",
            isCore: true,
            status: "fully_tested",
            apiEndpoint: "POST /v1/gm/thin-action",
            dataEntryFields: "action='authorize_payroll'",
            justification: "Highest-level emergency override via Prisma audit log."
          },
          {
             orderIndex: 2,
             title: "View P&L Real-time Ledger",
             isCore: true,
             status: "fully_tested",
             apiEndpoint: "GET /v1/finance/ledger/pnl",
             dataEntryFields: "dateRange",
             justification: "Live Double-Entry ledger aggregation. Gives GM instant agency valuation and margin."
          }
        ]
      }
    ]
  },
  {
    roleName: "mt",
    screens: [
      {
        orderIndex: 1,
        name: "MT Analytics Hub",
        route: "/mt_home",
        status: "completed",
        description: "Algorithmic adjustment chamber. Allows the MT to balance the platform ecosystem parameters directly (surge limits, algorithm blocks).",
        functions: [
          {
            orderIndex: 1,
            title: "Clear Overtime Bottleneck",
            isCore: true,
            status: "fully_tested",
            apiEndpoint: "POST /v1/mt/thin-action",
            dataEntryFields: "action='clear_overtime_bottleneck'",
            justification: "Resolves algorithmic stuck states for MTs."
          },
          {
             orderIndex: 2,
             title: "Adjust Surge Pricing Config",
             isCore: false,
             status: "fully_tested",
             apiEndpoint: "PATCH /v1/system/ecosystem/config",
             dataEntryFields: "maxDailySurgeBudget",
             justification: "Allows algorithmic throttling. This prevents the agency from bankrupting itself when paying PSW holiday surges."
          }
        ]
      }
    ]
  },
  {
    roleName: "scrum_master",
    screens: [
      {
        orderIndex: 1,
        name: "Scrum Master Operations",
        route: "/scrum_master/home",
        status: "completed",
        description: "DevOps and raw queue processing terminal. Bypasses all business logic to directly manage the physical state of the server infrastructure.",
        functions: [
          {
            orderIndex: 1,
            title: "Flush Dead Letter Queue",
            isCore: true,
            status: "fully_tested",
            apiEndpoint: "POST /v1/scrum-master/ops/clear-dlq",
            dataEntryFields: "flush: boolean",
            justification: "Provides physical Queue resets to prevent system stall."
          }
        ]
      },
      {
        orderIndex: 2,
        name: "Platform Tracking Matrix",
        route: "/scrum_master/tracking",
        status: "completed",
        description: "The live development feedback loop. Enables administrators to verify what features are explicitly active right now across any Tenant without asking engineers.",
        functions: [
          {
            orderIndex: 1,
            title: "View All Features Status",
            isCore: true,
            status: "fully_tested",
            apiEndpoint: "GET /v1/tracking",
            dataEntryFields: "none",
            justification: "Loads the entire Role/Screen/Function tree dynamically."
          },
          {
            orderIndex: 2,
            title: "Update Implementation Status",
            isCore: true,
            status: "fully_tested",
            apiEndpoint: "PATCH /v1/tracking/functions/:id",
            dataEntryFields: "status enum",
            justification: "Live DB mutations from the UI to mark a feature fully tested."
          }
        ]
      }
    ]
  },
  {
    roleName: "superuser",
    screens: [
      {
        orderIndex: 1,
        name: "Superuser Control Sync",
        route: "/superuser/sync",
        status: "completed",
        description: "The ultimate God-mode interface. Only used for system-wide overrides and pushing updates across all fractured multi-tenant environments simultaneously.",
        functions: [
          {
            orderIndex: 1,
            title: "Cross-Tenant Isolation Sync",
            isCore: true,
            status: "fully_tested",
            apiEndpoint: "POST /v1/superuser/isolation/override-sync",
            dataEntryFields: "isolation_check='bypass_ok'",
            justification: "High privileged bypass command that forces a sandbox sync."
          },
          {
            orderIndex: 2,
            title: "Deploy Dynamic Registry Patch",
            isCore: true,
            status: "fully_tested",
            apiEndpoint: "POST /v1/registry/sync",
            dataEntryFields: "registryKey, newJsonPayload",
            justification: "Modifies standard UI strings/styles across all tenants instantly globally."
          }
        ]
      }
    ]
  }
];

async function seed() {
  console.log('Seeding Serial Numbers & Architectural Descriptions...');
  
  for (const roleData of ROLES_AND_SCREENS) {
    let role = await prisma.platformRole.findUnique({ where: { name: roleData.roleName } });
    if (!role) { role = await prisma.platformRole.create({ data: { name: roleData.roleName }}); }

    for (const screenData of roleData.screens) {
      let screen = await prisma.platformScreen.findFirst({
        where: { roleId: role.id, route: screenData.route }
      });
      
      if (!screen) {
        screen = await prisma.platformScreen.create({
          data: {
            roleId: role.id,
            name: screenData.name,
            route: screenData.route,
            status: screenData.status,
            description: screenData.description,
            orderIndex: screenData.orderIndex
          }
        });
        console.log(`  Created Screen: ${screenData.orderIndex} ${screenData.name}`);
      } else {
        await prisma.platformScreen.update({
             where: { id: screen.id },
             data: {
                 description: screenData.description,
                 orderIndex: screenData.orderIndex
             }
        });
      }

      for (const func of screenData.functions) {
        const existingFunc = await prisma.screenFunctionality.findFirst({
          where: { screenId: screen.id, title: func.title }
        });

        if (!existingFunc) {
          await prisma.screenFunctionality.create({
            data: {
              screenId: screen.id,
              title: func.title,
              isCore: func.isCore,
              status: func.status,
              apiEndpoint: func.apiEndpoint,
              dataEntryFields: func.dataEntryFields,
              justification: func.justification,
              orderIndex: func.orderIndex
            }
          });
          console.log(`    Created Function: ${func.title}`);
        } else {
            await prisma.screenFunctionality.update({
                where: { id: existingFunc.id },
                data: {
                    apiEndpoint: func.apiEndpoint,
                    dataEntryFields: func.dataEntryFields,
                    justification: func.justification,
                    status: func.status,
                    orderIndex: func.orderIndex
                }
            });
            console.log(`    Updated Function: ${func.orderIndex} ${func.title}`);
        }
      }
    }
  }
  console.log('Massive Serialized Seed Update Complete!');
}

seed()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
