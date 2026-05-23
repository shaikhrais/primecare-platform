// Governance - Category: service | Purpose: Core implementation file for the Ops Coordination platform logic.
export const opsCoordinationContent = {
    MANAGER_OPERATIONS: {
        TITLE: 'Regional Operations Hub',
        SUBTITLE: 'Cross-branch administrative and logistics triage.',
        TABS: {
            LOGISTICS: 'Logistics Overview',
            COMPLIANCE: 'Regional Compliance',
            TICKETS: 'Support Tickets',
        },
        ALERTS: {
            HIGH_RISK: 'High Risk Branch Alert',
            STAFFING_GAP: 'Regional Staffing Gap',
            COMPLIANCE_DROP: 'Compliance Variance Detected',
        },
        KPI: {
            LOGISTICS_EFFICIENCY: 'Logistics Efficiency',
            REVENUE: 'Regional Revenue Accrual',
            UTILIZATION: 'Regional Staffing Utilization',
            TURNOVER: 'Regional Turnover',
            COMPLIANCE: 'Regional Compliance',
            COMPLIANCE_RATE: 'Average Compliance Rate',
            AUDIT_PROGRESS: 'Regional Audit Progress',
        },
        GRID: {
            BRANCH: 'Branch',
            MANAGER: 'Branch Manager',
            HEALTH: 'Health Score',
            LAST_AUDIT: 'Last Audit',
        },
        ACTIONS: {
            AUDIT: 'Initiate Regional Audit',
            SYNC: 'Sync branch ledgers',
            GLOBAL_SYNC: 'Regional Satellite Sync',
            DOWNLOAD_REPORT: 'Download Operations Report',
        },
        MESSAGES: {
            AUDIT_START: 'Regional audit sequence initiated...',
            SYNC_SUCCESS: 'All branch data synchronized',
        }
    },
    COORDINATOR_WAITLIST: {
        TITLE: 'Waitlist Management',
        SUBTITLE: 'Prioritize and match clients awaiting care.',
        COLUMNS: {
            PRIORITY: 'Priority Rank',
            CLIENT: 'Client Name',
            STATUS: 'Waitlist Status',
            SINCE: 'Waiting Since',
            ENTRY_DATE: 'Date Added',
            URGENCY: 'Clinical Urgency',
            ACUITY: 'Clinical Acuity Score',
            PREFERENCE: 'Provider Preference',
        },
        ACTIONS: {
            MATCH: 'Execute Match',
            PRIORITIZE: 'Adjust Priority',
            BOOST_PRIORITY: 'Priority Elevation',
            ASSIGN_STAFF: 'Manual Caregiver Assignment',
            REMOVE: 'Remove from List',
        },
        MESSAGES: {
            SUCCESS_MATCH: 'Client matched successfully',
            ERROR_MATCH: 'Failed to find suitable match',
        }
    },
    COORDINATOR_SOS: {
        TITLE: 'Emergency Response Center',
        SUBTITLE: 'Real-time SOS monitoring and clinical triage.',
        ALERTS_TITLE: 'Active Clinical SOS Alerts',
        FORM: {
            RESOLUTION_LABEL: 'Resolution Summary',
            PLACEHOLDER_RESOLUTION: 'Describe clinical outcome, dispatch status...',
            INCIDENT_LOG: 'Emergency Incident Log',
            RESOLVE_BTN: 'Finalize Resolution',
        },
        TABLE: {
            TIME: 'Alert Time',
            PSW: 'Caregiver',
            CLIENT: 'Patient',
            LOCATION: 'Live GPS',
            STATUS: 'Alert Status',
        },
        ACTIONS: {
            ACKNOWLEDGE: 'Acknowledge SOS',
            DISPATCH: 'Dispatch Emergency Services',
            RESOLVE: 'Mark as Resolved',
        },
        MESSAGES: {
            SUCCESS_ACK: 'SOS alert acknowledged and escalated',
            ERROR_ACK: 'Failed to acknowledge SOS',
            LOCK_WARNING: 'Another coordinator is currently responding to this alert.',
            NO_ALERTS: 'No active clinical SOS alerts detected.',
        }
    },
    COORDINATOR_MAP: {
        TITLE: 'Live Logistics Map',
        SUBTITLE: 'Real-time spatial visualization of regional clinical operations.',
        LEGEND: {
            ACTIVE: 'Active Visit',
            IDLE: 'Idle/Travel',
            SOS: 'SOS Alert',
            CLIENT: 'Client Location',
        },
        ACTIONS: {
            REFRESH: 'Refresh Fleet Data',
            CENTER: 'Center on Region',
            FILTER: 'Filter Assets',
        }
    },
} as const;
