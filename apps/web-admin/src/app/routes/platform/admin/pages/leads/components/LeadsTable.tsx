import React from 'react';
import EmptyState from '@/shared/components/layout/EmptyState';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useDialog } from '@/shared/hooks/useDialog';

const { RouteRegistry, ButtonRegistry } = AdminRegistry;

interface Lead {
    id: string;
    firstName?: string;
    lastName?: string;
    fullName?: string;
    email: string;
    phone: string;
    serviceInterest: string[];
    status: 'new' | 'contacted' | 'consultation_scheduled' | 'converted' | 'lost';
    createdAt: string;
    notes?: string;
}

interface LeadsTableProps {
    leads: Lead[];
    loading: boolean;
    searchTerm: string;
    onStatusChange: (id: string, status: Lead['status']) => void;
    onDelete: (id: string) => void;
}

export const LeadsTable: React.FC<LeadsTableProps> = ({ leads, loading, searchTerm, onStatusChange, onDelete }) => {
    const { confirm, DialogRenderer } = useDialog();
    const navigate = useNavigate();
    const CONTENT = AdminRegistry.ContentRegistry.ADMIN_LEADS;
    const COMMON = AdminRegistry.ContentRegistry.COMMON;

    const filteredLeads = leads.filter(l => {
        const search = searchTerm.toLowerCase();
        const first = (l.firstName || '').toLowerCase();
        const last = (l.lastName || '').toLowerCase();
        const email = (l.email || '').toLowerCase();
        // Support fullName if coming from API
        const full = (l as any).fullName?.toLowerCase() || '';

        return first.includes(search) ||
            last.includes(search) ||
            email.includes(search) ||
            full.includes(search);
    });

    const getStatusColor = (status: string) => {
        switch (status) {
            case 'new': return '#3b82f6';
            case 'contacted': return '#f59e0b';
            case 'consultation_scheduled': return '#8b5cf6';
            case 'converted': return '#10b981';
            case 'lost': return '#ef4444';
            default: return '#6b7280';
        }
    };

    return (
        <div style={{ backgroundColor: 'white', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }} data-cy="tbl.leads">
                <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                    <tr>
                        <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>{CONTENT.TABLE.NAME}</th>
                        <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>{CONTENT.TABLE.CONTACT}</th>
                        <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>{CONTENT.TABLE.INTEREST}</th>
                        <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>{CONTENT.TABLE.STATUS}</th>
                        <th style={{ padding: '1rem', fontWeight: '600', color: '#374151' }}>{CONTENT.TABLE.DATE}</th>
                        <th style={{ padding: '1rem', fontWeight: '600', color: '#374151', textAlign: 'right' }}>{CONTENT.TABLE.ACTIONS}</th>
                    </tr>
                </thead>
                <tbody>
                    {loading ? (
                        <tr>
                            <td colSpan={6} style={{ padding: '2rem', textAlign: 'center', color: '#6b7280' }}>{CONTENT.MESSAGES.LOADING}</td>
                        </tr>
                    ) : filteredLeads.length > 0 ? (
                        filteredLeads.map((lead) => (
                            <tr key={lead.id} style={{ borderBottom: '1px solid #f3f4f6' }} data-cy={`row-lead-${lead.id}`}>
                                <td style={{ padding: '1rem', fontWeight: '500', color: '#111827' }}>
                                    {lead.firstName || lead.lastName ? `${lead.firstName || ''} ${lead.lastName || ''}`.trim() : (lead as any).fullName || COMMON.FALLBACKS.REGISTRY_NODE}
                                </td>
                                <td style={{ padding: '1rem', color: '#4b5563' }}>
                                    <div style={{ fontSize: '0.875rem' }}>{lead.email}</div>
                                    <div style={{ fontSize: '0.75rem', color: '#9ca3af' }}>{lead.phone}</div>
                                </td>
                                <td style={{ padding: '1rem', color: '#4b5563' }}>
                                    <div style={{ display: 'flex', gap: '0.25rem', flexWrap: 'wrap' }}>
                                        {(lead.serviceInterest || []).map((interest, i) => (
                                            <span key={i} style={{ fontSize: '0.75rem', backgroundColor: '#e5e7eb', padding: '0.125rem 0.375rem', borderRadius: '9999px' }}>
                                                {interest}
                                            </span>
                                        ))}
                                    </div>
                                </td>
                                <td style={{ padding: '1rem' }}>
                                    <select data-cy="select-admin.leads-table-0"
                                        value={lead.status}
                                        onChange={(e) => onStatusChange(lead.id, e.target.value as any)}
                                        style={{
                                            padding: '0.25rem 0.5rem',
                                            borderRadius: '9999px',
                                            fontSize: '0.75rem',
                                            fontWeight: '600',
                                            border: 'none',
                                            backgroundColor: `${getStatusColor(lead.status)}20`,
                                            color: getStatusColor(lead.status),
                                            cursor: 'pointer'
                                        }}
                                        data-cy={`sel-status-${lead.id}`}
                                    >
                                        <option value="new">{CONTENT.STATUS.NEW}</option>
                                        <option value="contacted">{CONTENT.STATUS.CONTACTED}</option>
                                        <option value="consultation_scheduled">{CONTENT.STATUS.CONSULTATION}</option>
                                        <option value="converted">{CONTENT.STATUS.CONVERTED}</option>
                                        <option value="lost">{CONTENT.STATUS.LOST}</option>
                                    </select>
                                </td>
                                <td style={{ padding: '1rem', color: '#6b7280', fontSize: '0.875rem' }}>
                                    {new Date(lead.createdAt).toLocaleDateString()}
                                </td>
                                <td style={{ padding: '1rem', textAlign: 'right', display: 'flex', gap: '0.5rem', justifyContent: 'flex-end' }}>
                                    <button data-cy="btn-admin.leads-table-0"
                                        onClick={() => navigate(RouteRegistry.ADMIN.LEADS_CONVERT(lead.id))}
                                        style={{ color: '#059669', background: '#ecfdf5', border: '1px solid #10b981', padding: '0.25rem 0.5rem', borderRadius: '0.25rem', cursor: 'pointer', fontWeight: '600', fontSize: '0.75rem' }}
                                        data-cy={`btn-adm-leads-convert-${lead.id}`}
                                    >
                                        {AdminRegistry.ButtonRegistry.find((b: any) => b.id === 'btn-adm-leads-convert')?.label || 'Convert'}
                                    </button>
                                    <button data-cy="btn-admin.leads-table-1"
                                        onClick={() => {
                                            confirm('Delete Lead', CONTENT.MESSAGES.CONFIRM_DELETE).then(ok => { if (ok) onDelete(lead.id); });
                                        }}
                                        style={{ color: '#ef4444', background: 'none', border: 'none', cursor: 'pointer', fontWeight: '500', fontSize: '0.75rem' }}
                                        data-cy={`btn-delete-${lead.id}`}
                                    >
                                        {COMMON.DELETE}
                                    </button>
                                </td>
                            </tr>
                        ))
                    ) : (
                        <tr>
                            <td colSpan={6} style={{ padding: '2rem' }}>
                                <EmptyState
                                    title={searchTerm ? String(CONTENT.MESSAGES.EMPTY_SEARCH) : String(CONTENT.MESSAGES.EMPTY_LIST)}
                                    description={searchTerm ? 'Try adjusting your search terms.' : 'There are no active CRM leads or inquiries at this time.'}
                                    icon="🔍"
                                />
                            </td>
                        </tr>
                    )}
                </tbody>
            </table>
        <DialogRenderer />
            </div>
    );
};
