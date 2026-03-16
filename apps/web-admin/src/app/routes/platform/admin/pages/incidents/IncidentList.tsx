import React, { useEffect, useState } from 'react';
import EmptyState from '@/shared/components/layout/EmptyState';
import { useNavigate, Link } from 'react-router';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { fetchIncidents as apiFetchIncidents, resolveIncident, deleteIncident, filterIncidents } from './incidentHandlers';

// Components
import { IncidentResolutionModal } from './components/IncidentResolutionModal';
import DangerModal from '@/shared/components/modals/DangerModal';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function IncidentList() {
    const { t } = useTranslation();
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [incidents, setIncidents] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [selectedIncident, setSelectedIncident] = useState<string | null>(null);
    const [submitting, setSubmitting] = useState(false);

    // Deletion mechanics
    const [isDangerModalOpen, setIsDangerModalOpen] = useState(false);
    const [incidentToDelete, setIncidentToDelete] = useState<any>(null);

    // Filters
    const [statusFilter, setStatusFilter] = useState<string>('all');
    const [typeFilter, setTypeFilter] = useState<string>('all');

    const filteredIncidents = filterIncidents(incidents, statusFilter, typeFilter);

    useEffect(() => { loadIncidents(); }, []);

    const loadIncidents = async () => {
        setLoading(true);
        setIncidents(await apiFetchIncidents());
        setLoading(false);
    };

    const handleResolve = async (resolutionNotes: string) => {
        if (!selectedIncident) return;
        setSubmitting(true);
        try {
            if (await resolveIncident(selectedIncident, resolutionNotes)) {
                setIncidents(incidents.map((inc: any) => inc.id === selectedIncident ? { ...inc, status: 'resolved', resolutionNotes } : inc));
                setIsModalOpen(false);
                showToast(t(ContentRegistry.INCIDENTS.RESOLVE.SUCCESS), 'success');
            }
        } catch (error) {
            showToast(t(ContentRegistry.INCIDENTS.RESOLVE.ERROR), 'error');
        } finally { setSubmitting(false); }
    };

    const handleDelete = async () => {
        if (!incidentToDelete) return;
        try {
            if (await deleteIncident(incidentToDelete.id)) {
                setIncidents(incidents.filter((inc: any) => inc.id !== incidentToDelete.id));
                showToast(t('incidents.delete_success', 'Incident deleted successfully'), 'success');
            } else {
                showToast(t('incidents.delete_error', 'Failed to delete incident'), 'error');
            }
        } catch (error) {
            showToast(t('incidents.delete_error', 'Failed to delete incident'), 'error');
        } finally { setIsDangerModalOpen(false); }
    };


    if (loading) return <div style={{ padding: '2rem' }}>{t(ContentRegistry.INCIDENTS.TABLE.LOADING)}</div>;

    return (
        <div style={{ padding: '2rem' }} data-cy="incident-list-page">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0 }} data-cy="page.title">{t(ContentRegistry.INCIDENTS.TITLE)}</h2>
                <button
                    data-cy="btn.incident.report"
                    onClick={() => navigate(RouteRegistry.ADMIN.INCIDENTS_NEW)}
                    style={{ padding: '0.625rem 1.25rem', backgroundColor: '#e11d48', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                >
                    {t(ContentRegistry.INCIDENTS.ADD_BTN)}
                </button>
            </div>

            <div style={{ display: 'flex', gap: '1rem', marginBottom: '1.5rem', backgroundColor: 'var(--bg-200, #f9fafb)', padding: '1rem', borderRadius: '0.5rem', border: '1px solid var(--border, #e5e7eb)' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                    <label style={{ fontSize: '0.875rem', fontWeight: 500, color: 'var(--text-100, #374151)' }}>{t('incidents.filter_status', { defaultValue: 'Status:' })}</label>
                    <select data-cy="select-admin.incident-list-0"
                        value={statusFilter}
                        onChange={(e) => setStatusFilter(e.target.value)}
                        style={{ padding: '0.375rem 0.75rem', borderRadius: '0.375rem', border: '1px solid var(--border, #d1d5db)', fontSize: '0.875rem', backgroundColor: 'var(--bg)' }}
                    >
                        <option value="all">{t('incidents.status_all', { defaultValue: 'All Statuses' })}</option>
                        <option value="open">{t('incidents.status_open', { defaultValue: 'Open' })}</option>
                        <option value="investigating">{t('incidents.status_investigating', { defaultValue: 'Investigating' })}</option>
                        <option value="resolved">{t('incidents.status_resolved', { defaultValue: 'Resolved' })}</option>
                    </select>
                </div>
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                    <label style={{ fontSize: '0.875rem', fontWeight: 500, color: 'var(--text-100, #374151)' }}>{t('incidents.filter_type', { defaultValue: 'Type:' })}</label>
                    <select data-cy="select-admin.incident-list-1"
                        value={typeFilter}
                        onChange={(e) => setTypeFilter(e.target.value)}
                        style={{ padding: '0.375rem 0.75rem', borderRadius: '0.375rem', border: '1px solid var(--border, #d1d5db)', fontSize: '0.875rem', backgroundColor: 'var(--bg)' }}
                    >
                        <option value="all">{t('incidents.type_all', { defaultValue: 'All Types' })}</option>
                        <option value="clinical">{t('incidents.type_clinical', { defaultValue: 'Clinical' })}</option>
                        <option value="operational">{t('incidents.type_operational', { defaultValue: 'Operational' })}</option>
                        <option value="security">{t('incidents.type_security', { defaultValue: 'Security' })}</option>
                    </select>
                </div>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '0.5rem', border: '1px solid #e5e7eb', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse' }} data-cy="tbl-incidents">
                    <thead style={{ backgroundColor: '#f9fafb' }}>
                        <tr>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>{t(ContentRegistry.INCIDENTS.TABLE.TYPE)}</th>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>{t(ContentRegistry.INCIDENTS.TABLE.REPORTER)}</th>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>{t(ContentRegistry.INCIDENTS.TABLE.STATUS)}</th>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>{t(ContentRegistry.INCIDENTS.TABLE.DATE)}</th>
                            <th style={{ textAlign: 'left', padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>{t(ContentRegistry.INCIDENTS.TABLE.ACTIONS)}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {filteredIncidents.length === 0 ? (
                            <tr>
                                <td colSpan={5} style={{ padding: '2rem' }}>
                                    <EmptyState
                                        title={t('incidents.empty_title', { defaultValue: 'No Incidents Found' })}
                                        description={t('incidents.empty_desc', { defaultValue: 'There are currently no incidents matching the selected criteria.' })}
                                        icon="🚨"
                                        actionLabel={t(ContentRegistry.INCIDENTS?.ADD_BTN || 'Report Incident')}
                                        onAction={() => navigate(RouteRegistry.ADMIN.INCIDENTS_NEW)}
                                    />
                                </td>
                            </tr>
                        ) : (
                            filteredIncidents.map((incident: any) => (
                                <tr key={incident.id} data-cy={`incident-row-${incident.id}`}>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }} data-cy="incident-type">{incident.type}</td>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid var(--line, #e5e7eb)' }} data-cy="incident-reporter">
                                        <Link
                                            to={`${AdminRegistry.RouteRegistry.ADMIN.USERS}?search=${incident.reporter?.email}`}
                                            style={{ color: 'var(--brand-500, #00875A)', textDecoration: 'none', fontWeight: 500 }}
                                        >
                                            {incident.reporter?.email}
                                        </Link>
                                    </td>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid var(--line, #e5e7eb)' }}>
                                        <span data-cy="incident-status" style={{
                                            padding: '0.25rem 0.5rem',
                                            borderRadius: '9999px',
                                            fontSize: '0.75rem',
                                            backgroundColor: incident.status === 'open' ? 'var(--bg-danger, #fee2e2)' : 'var(--bg-success, #d1fae5)',
                                            color: incident.status === 'open' ? 'var(--text-danger, #991b1b)' : 'var(--text-success, #065f46)'
                                        }}>
                                            {t(`incidents.status_${incident.status}`, { defaultValue: incident.status })}
                                        </span>
                                    </td>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>{new Date(incident.createdAt).toLocaleDateString()}</td>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>
                                        <div style={{ display: 'flex', gap: '1rem', alignItems: 'center' }}>
                                            {incident.status === 'open' && (
                                                <button
                                                    data-cy="btn.incident.resolve"
                                                    onClick={() => {
                                                        setSelectedIncident(incident.id);
                                                        setIsModalOpen(true);
                                                    }}
                                                    style={{ color: '#00875A', border: 'none', background: 'none', cursor: 'pointer', padding: 0, fontWeight: 500 }}
                                                >
                                                    {t(ContentRegistry.INCIDENTS.RESOLVE.BTN)}
                                                </button>
                                            )}
                                            <button
                                                data-cy="btn.incident.delete"
                                                onClick={() => {
                                                    setIncidentToDelete(incident);
                                                    setIsDangerModalOpen(true);
                                                }}
                                                style={{ color: '#ef4444', border: 'none', background: 'none', cursor: 'pointer', padding: 0, fontWeight: 500 }}
                                            >
                                                {t('common.delete', 'Delete')}
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            ))
                        )}
                    </tbody>
                </table>
            </div>

            <IncidentResolutionModal
                isOpen={isModalOpen}
                onClose={() => setIsModalOpen(false)}
                onResolve={handleResolve}
                submitting={submitting}
            />

            <DangerModal
                isOpen={isDangerModalOpen}
                title={t('incidents.delete_modal_title', 'Delete Incident')}
                description={t('incidents.delete_modal_desc', 'This action cannot be undone. This will permanently delete the incident record from the database.')}
                targetName={incidentToDelete?.type || 'INCIDENT'}
                onClose={() => setIsDangerModalOpen(false)}
                onConfirm={handleDelete}
            />
        </div >
    );
}
