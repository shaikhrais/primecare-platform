import React, { useEffect, useState } from 'react';
import EmptyState from '@/shared/components/layout/EmptyState';
import { useNavigate, Link } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import { useTranslation } from 'react-i18next';
import { useNotification } from '@/shared/context/NotificationContext';

// Components
import { IncidentResolutionModal } from './components/IncidentResolutionModal';

const { ApiRegistry, ContentRegistry, RouteRegistry } = AdminRegistry;

export default function IncidentList() {
    const { t } = useTranslation();
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [incidents, setIncidents] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [selectedIncident, setSelectedIncident] = useState<string | null>(null);
    const [submitting, setSubmitting] = useState(false);

    useEffect(() => {
        fetchIncidents();
    }, []);

    const fetchIncidents = async () => {
        setLoading(true);
        try {
            const response = await apiClient.get(ApiRegistry.ADMIN.INCIDENTS);
            if (response.ok) {
                const data = await response.json();
                setIncidents(data);
            }
        } catch (error) {
            console.error('Failed to fetch incidents', error);
        } finally {
            setLoading(false);
        }
    };

    const handleResolve = async (resolutionNotes: string) => {
        if (!selectedIncident) return;
        setSubmitting(true);

        try {
            const response = await apiClient.patch(`${ApiRegistry.ADMIN.INCIDENTS}/${selectedIncident}`, {
                status: 'resolved',
                resolutionNotes
            });

            if (response.ok) {
                setIncidents(incidents.map((inc: any) => inc.id === selectedIncident ? { ...inc, status: 'resolved', resolutionNotes } : inc));
                setIsModalOpen(false);
                showToast(t(ContentRegistry.INCIDENTS.RESOLVE.SUCCESS), 'success');
            }
        } catch (error) {
            showToast(t(ContentRegistry.INCIDENTS.RESOLVE.ERROR), 'error');
        } finally {
            setSubmitting(false);
        }
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
                        {incidents.length === 0 ? (
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
                            incidents.map((incident: any) => (
                                <tr key={incident.id} data-cy={`incident-row-${incident.id}`}>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }} data-cy="incident-type">{incident.type}</td>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }} data-cy="incident-reporter">
                                        <Link
                                            to={`${AdminRegistry.RouteRegistry.ADMIN.USERS}?search=${incident.reporter?.email}`}
                                            style={{ color: '#00875A', textDecoration: 'none', fontWeight: 500 }}
                                        >
                                            {incident.reporter?.email}
                                        </Link>
                                    </td>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>
                                        <span data-cy="incident-status" style={{
                                            padding: '0.25rem 0.5rem',
                                            borderRadius: '9999px',
                                            fontSize: '0.75rem',
                                            backgroundColor: incident.status === 'open' ? '#fee2e2' : '#d1fae5',
                                            color: incident.status === 'open' ? '#991b1b' : '#065f46'
                                        }}>
                                            {incident.status}
                                        </span>
                                    </td>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>{new Date(incident.createdAt).toLocaleDateString()}</td>
                                    <td style={{ padding: '1rem', borderBottom: '1px solid #e5e7eb' }}>
                                        {incident.status === 'open' && (
                                            <button
                                                data-cy="btn.incident.resolve"
                                                onClick={() => {
                                                    setSelectedIncident(incident.id);
                                                    setIsModalOpen(true);
                                                }}
                                                style={{ color: '#4db6ac', border: 'none', background: 'none', cursor: 'pointer', padding: 0 }}
                                            >
                                                {t(ContentRegistry.INCIDENTS.RESOLVE.BTN)}
                                            </button>
                                        )}
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
        </div >
    );
}
