// E2E Runner: pipeline configuration extracted
import React from 'react';
import { Box, Database, UserPlus, FileSignature, Activity, Send, MapPin } from 'lucide-react';

export interface PipelineStep {
    id: string; label: string; description: string; icon: React.ReactNode;
    status: 'idle' | 'running' | 'success' | 'error'; logs: any[]; delayMs: number;
}

export const INITIAL_PIPELINE: PipelineStep[] = [
    { id: 'brand', label: 'Initialize Platform', description: 'Creating Master Tenant & Brand Profile', icon: <Box size={20} />, status: 'idle', logs: [], delayMs: 1200 },
    { id: 'admin', label: 'Super Admin Onboarding', description: 'Generating Root Administrator Credentials', icon: <Database size={20} />, status: 'idle', logs: [], delayMs: 800 },
    { id: 'staff', label: 'Hire Operations Team', description: 'Onboarding System Manager & Care Coordinator', icon: <UserPlus size={20} />, status: 'idle', logs: [], delayMs: 1500 },
    { id: 'provider', label: 'Onboard Healthcare Provider', description: 'Register PSW / RN profiles and set availability', icon: <FileSignature size={20} />, status: 'idle', logs: [], delayMs: 1800 },
    { id: 'client', label: 'Register Client Profile', description: 'Import Patient Medical History & Contacts', icon: <Activity size={20} />, status: 'idle', logs: [], delayMs: 1100 },
    { id: 'booking', label: 'Dispatch Care Visit', description: 'Automated Match & Shift Assignment', icon: <Send size={20} />, status: 'idle', logs: [], delayMs: 2500 },
    { id: 'evv', label: 'Field Worker EVV', description: 'Execute GPS Clock-In mapping check', icon: <MapPin size={20} />, status: 'idle', logs: [], delayMs: 1400 },
];

export function getTestData(stepId: string): any {
    const map: Record<string, any> = {
        brand: { tenantId: 'tnt_9f8a7', primaryRegion: 'us-east-1', dbAllocation: 'provisioned' },
        admin: { adminId: 'usr_root', rbacRole: 'super_admin', assignedToken: 'eyJhbGciOiJIUzI...[REDACTED]' },
        staff: { recordsCreated: 2, managerId: 'usr_mgr99', coordinatorId: 'usr_cord81' },
        provider: { providerIds: ['psw_481a', 'rn_88b1'], specialtiesMined: ['geriatric', 'wound_care'] },
        client: { patientId: 'pat_0083', tags: ['fall_risk', 'dementia'], geocode: { lat: 43.6532, lng: -79.3832 } },
        booking: { shiftId: 'shf_777x', assignedTo: 'psw_481a', date: '2026-03-11', duration: '4h' },
        evv: { status: 'Verified', GPS_Lock: 'True', diffMeters: 12.4, compliance: 'Passed' },
    };
    return map[stepId] || null;
}
