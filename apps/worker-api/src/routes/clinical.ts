// Governance - Category: middleware | Purpose: Core implementation file for the Clinical platform logic.
import { Hono } from 'hono'

export const clinicalRouter = new Hono()

clinicalRouter.get('/metrics/:officeId', async (c) => {
  const officeId = c.req.param('officeId')
  
  return c.json({
    data: {
      officeId,
      patientCount: 350,
      averageWaitTimeMins: 14.5,
      criticalIncidents: 0
    }
  })
})

clinicalRouter.get('/patients/:officeId', async (c) => {
  const officeId = c.req.param('officeId')
  
  return c.json({
    data: [
      { id: '101', name: 'John Doe', status: 'STABLE', lastVisit: new Date().toISOString() },
      { id: '102', name: 'Jane Smith', status: 'CRITICAL', lastVisit: new Date().toISOString() }
    ]
  })
})

clinicalRouter.get('/dashboard', async (c) => {
  return c.json({
    status: 'success',
    data: {
      // Executive Summary
      residentsToday: 142,
      staffOnShift: 18,
      openShifts: 3,
      fallsToday: 1,
      incidentsToday: 2,
      hospitalTransfers: 1,
      staffAttendance: 96.5,
      activeOutbreaks: 0,

      // Resident Safety
      fallRate: 1.2,
      pressureUlcersCount: 2,
      wanderingAlertsCount: 0,
      missedRepositioningsCount: 1,
      weightLossRiskCount: 4,
      dehydrationAlertCount: 1,
      highRiskResidentsList: [
        { name: 'Alice Miller', riskType: 'Falls Risk / Dementia', status: 'High Monitoring' },
        { name: 'Robert Chen', riskType: 'Medication Support', status: 'Stable' },
        { name: 'Margaret Sullivan', riskType: 'Nutrition Risk', status: 'Assisted Feeding' }
      ],

      // Staffing
      pswToResidentRatio: '1:8',
      overtimeHours: 12.5,
      sickCalls: 2,
      agencyStaffUsage: 1,
      trainingCompletionRate: 98.2,
      expiringCertifications: 2,
      staffWorkloadList: [
        { name: 'Emily Watson (PSW)', load: 85.0, breaksSkipped: 0 },
        { name: 'James Davis (PSW Team Lead)', load: 70.0, breaksSkipped: 0 },
        { name: 'Sarah Connor (PSW)', load: 90.0, breaksSkipped: 1 }
      ],

      // Compliance
      missingADLChartingCount: 4,
      lateIncidentReportsCount: 1,
      overdueCarePlansCount: 2,
      privacyBreachCount: 0,
      activeAbuseInvestigationsCount: 0,

      // Infection Control
      activeInfectionsCount: 3,
      isolationCount: 2,
      ppeInventoryLevel: 'Adequate (30 days supply)',
      handHygieneAuditScore: 95.0,
      outbreakStatus: 'Clear',

      // Family & Experience
      activeComplaintsCount: 1,
      satisfactionRate: 94.2,
      pendingFamilyCallsCount: 3,
      moodTrends: 'Stable',

      // Financials
      profitMargin: 24.5,
      payrollRatio: 48.0,
      outstandingPayments: 1480,
      revenueByService: [
        { service: 'Home Care Services', amount: 18500 },
        { service: 'Retirement Resident Fees', amount: 24000 },
        { service: 'Agency Staff Provision', amount: 10000 }
      ],
      revenueByTherapist: [
        { name: 'East Wing (Retirement)', amount: 12000 },
        { name: 'West Wing (Assisted Living)', amount: 14000 },
        { name: 'Memory Care Unit', amount: 10000 },
        { name: 'Outpatient Home Care', amount: 6500 }
      ],

      // Operations / Unit utilization
      roomUtilization: [
        { room: 'East Wing (Retirement)', occupancy: 92.0 },
        { room: 'West Wing (Assisted Living)', occupancy: 88.0 },
        { room: 'Memory Care Unit', occupancy: 95.0 }
      ],
      inventoryAlerts: [
        { item: 'PPE Face Masks (N95)', level: 'Low (2 boxes remaining)' },
        { item: 'Hand Sanitizer Gel', level: 'Adequate' },
        { item: 'Linens / Patient Gowns', level: 'Adequate' }
      ],

      // Risk HUD (Red Flags)
      redFlags: [
        { id: '1', level: 'danger', type: 'safety', message: 'Repeated falls (2 in 48h) detected for resident John Smith.' },
        { id: '2', level: 'warning', type: 'compliance', message: '4 ADL charting logs missing for morning shift.' },
        { id: '3', level: 'warning', type: 'staff', message: 'Sarah Connor (PSW) schedule load exceeds 90% (burnout warning).' },
        { id: '4', level: 'warning', type: 'infection', message: 'Low hand-hygiene score (78%) in memory care unit.' }
      ]
    }
  })
})
