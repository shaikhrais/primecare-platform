import { ContentRegistry } from './ContentRegistry';

export interface SummaryKPI {
    id: string;
    label: string;
    unit?: string;
    icon?: string;
    apiPath?: string;
    targetRoute?: string;
    color?: 'red' | 'green' | 'blue' | 'amber' | 'gray';
}

export interface SummaryFilter {
    id: string;
    label: string;
    type: 'select' | 'date' | 'date-range' | 'text' | 'boolean';
    options?: { label: string; value: string }[];
    default?: any;
}

export interface SummaryContext {
    id: string;
    name: string;
    lastUpdated?: string;
    kpis: SummaryKPI[];
    filters: SummaryFilter[];
}

/**
 * SummaryRegistry: Centralized store for platform intelligence, KPIs, and filtering logic.
 * Consolidates fragmented data views into a single source of truth for dashboarding and reporting.
 */
export const SummaryRegistry: SummaryContext[] = [
    {
        id: 'admin-dashboard-kpis',
        name: 'Admin Dashboard Intelligence',
        lastUpdated: new Date().toISOString(),
        kpis: [
            { id: 'total-users', label: 'Total Users', icon: '👥', targetRoute: '/platform/admin/users' },
            { id: 'new-leads', label: 'New Inquiries', icon: '📥', targetRoute: '/platform/admin/leads' },
            { id: 'pending-visits', label: 'Pending Visits', icon: '📝', targetRoute: '/platform/admin/schedule' },
            { id: 'revenue-mtd', label: 'MTD Revenue', unit: '$', icon: '💰' }
        ],
        filters: [
            { id: 'regional-branch', label: 'Branch', type: 'select', options: [] },
            { id: 'date-range', label: 'Reporting Period', type: 'date-range' }
        ]
    },
    {
        id: 'psw-schedule-summary',
        name: 'PSW Performance Summary',
        lastUpdated: new Date().toISOString(),
        kpis: [
            { id: 'weekly-hours', label: 'Weekly Hours', unit: 'h', icon: '⏱️' },
            { id: 'on-time-percent', label: 'On-Time Rate', unit: '%', icon: '📈' },
            { id: 'client-rating', label: 'Avg Rating', icon: '⭐' }
        ],
        filters: [
            {
                id: 'visit-status',
                label: 'Status',
                type: 'select',
                options: [
                    { label: 'Scheduled', value: 'scheduled' },
                    { label: 'In Progress', value: 'in_progress' },
                    { label: 'Completed', value: 'completed' }
                ]
            }
        ]
    },
    {
        id: 'lead-management-filters',
        name: 'Lead Pipeline Governance',
        lastUpdated: new Date().toISOString(),
        kpis: [
            { id: 'conversion-rate', label: 'Conversion', unit: '%', icon: '🎯' },
            { id: 'avg-lead-age', label: 'Avg Age', unit: 'days', icon: '⏳' }
        ],
        filters: [
            {
                id: 'lead-status',
                label: 'Status',
                type: 'select',
                options: [
                    { label: 'New', value: 'new' },
                    { label: 'Contacted', value: 'contacted' },
                    { label: 'Consultation', value: 'consultation_scheduled' },
                    { label: 'Converted', value: 'converted' },
                    { label: 'Lost', value: 'lost' }
                ]
            },
            { id: 'service-interest', label: 'Interest', type: 'select', options: [] }
        ]
    },
    {
        id: 'coordinator-dashboard-stats',
        name: 'Logistics Command Intelligence',
        lastUpdated: new Date().toISOString(),
        kpis: [
            { id: 'live-psw', label: 'PSWs on Duty', icon: '📍', apiPath: '/v1/coordinator/dashboard/stats' },
            { id: 'sos-active', label: 'Active SOS', icon: '🚨', color: 'red' },
            { id: 'pending-offers', label: 'Open Shift Offers', icon: '📢' }
        ],
        filters: [
            { id: 'region', label: 'Region', type: 'select', options: [] },
            { id: 'incident-status', label: 'SOS Status', type: 'select', options: [{ label: 'Open', value: 'open' }, { label: 'Resolved', value: 'resolved' }] }
        ]
    }
];
