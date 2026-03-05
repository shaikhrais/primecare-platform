import React, { useState, useEffect } from 'react';
import { ContentRegistry, ApiRegistry, ButtonRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';
import './SosCenter.css';

const { COORDINATOR_SOS } = ContentRegistry;

export default function SosCenter() {
    const { showToast } = useNotification();
    const [incidents, setIncidents] = useState<any[]>([]);
    const [activeIncident, setActiveIncident] = useState<any>(null);
    const [log, setLog] = useState('');
    const [isResolving, setIsResolving] = useState(false);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchIncidents = async () => {
            try {
                const data = await apiClient.get(ApiRegistry.TENANCY.COORDINATOR.SOS_INCIDENTS);
                if (data && Array.isArray(data)) {
                    setIncidents(data);
                    if (data.length > 0) setActiveIncident(data[0]);
                }
            } catch (error) {
                console.error('Failed to fetch SOS incidents:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchIncidents();
    }, []);

    const [psws, setPsws] = useState<any[]>([]);
    const [selectedPsw, setSelectedPsw] = useState('');
    const [isDispatching, setIsDispatching] = useState(false);

    useEffect(() => {
        const fetchPsws = async () => {
            try {
                // Fetching via stats or a dedicated roster endpoint if available
                const data = await apiClient.get('/v1/admin/users?role=psw');
                if (data && Array.isArray(data)) setPsws(data);
            } catch (error) {
                console.error('Failed to fetch PSWs:', error);
            }
        };
        fetchPsws();
    }, []);

    const handleDispatch = async () => {
        if (!activeIncident || !selectedPsw) return;
        setIsDispatching(true);
        try {
            await apiClient.post(ApiRegistry.TENANCY.COORDINATOR.SOS_DISPATCH, {
                incidentId: activeIncident.id,
                pswId: selectedPsw,
                notes: `Emergency dispatch initiated by coordinator.`
            });
            showToast('Emergency replacement dispatched.', 'success');
            // Refresh
            const data = await apiClient.get(ApiRegistry.TENANCY.COORDINATOR.SOS_INCIDENTS);
            if (data && Array.isArray(data)) {
                setIncidents(data);
                setActiveIncident(data.find((i: any) => i.id === activeIncident.id) || null);
            }
        } catch (error) {
            console.error('Dispatch failed', error);
        } finally {
            setIsDispatching(false);
        }
    };

    const handleResolve = async () => {
        if (!activeIncident) return;
        setIsResolving(true);
        try {
            await apiClient.post(ApiRegistry.TENANCY.COORDINATOR.SOS_ACK, {
                incidentId: activeIncident.id,
                notes: log
            });
            // Refresh list
            const data = await apiClient.get(ApiRegistry.TENANCY.COORDINATOR.SOS_INCIDENTS);
            if (data && Array.isArray(data)) {
                setIncidents(data);
                const updated = data.find((i: any) => i.id === activeIncident.id);
                if (updated) setActiveIncident(updated);
            }
            setLog('');
        } catch (error) {
            console.error('Failed to resolve SOS:', error);
        } finally {
            setIsResolving(false);
        }
    };

    if (loading) return <div className="sos-center-container">Synchronizing Emergency Link...</div>;

    const currentInc = activeIncident;

    return (
        <div className="sos-center-container">
            <header className="sos-header">
                <div>
                    <h1>{COORDINATOR_SOS.TITLE}</h1>
                    <p style={{ color: '#94a3b8', fontSize: '1.1rem' }}>{COORDINATOR_SOS.SUBTITLE}</p>
                </div>
                <div className="pc-badge danger" style={{ padding: '0.5rem 1rem', fontSize: '1rem' }}>LIVE EMERGENCY LINK</div>
            </header>

            <div className="alert-grid">
                <section className="sos-card">
                    {!currentInc ? (
                        <div className="empty-state" style={{ padding: '60px', textAlign: 'center' }}>
                            {COORDINATOR_SOS.MESSAGES.NO_ALERTS}
                        </div>
                    ) : (
                        <>
                            <div className="emergency-marker">
                                <span className="marker-dot"></span>
                                <h2 className="sos-title">Active SOS Trigger: {currentInc.visit?.psw?.fullName || 'Unknown PSW'}</h2>
                            </div>

                            <div className="incident-details">
                                <div className="detail-row">
                                    <span className="detail-label">Location</span>
                                    <span className="detail-value">{currentInc.visit?.client?.addressLine1 || 'Unknown'}</span>
                                </div>
                                <div className="detail-row">
                                    <span className="detail-label">Trigger Time</span>
                                    <span className="detail-value">{new Date(currentInc.createdAt).toLocaleTimeString()}</span>
                                </div>
                                <div className="detail-row">
                                    <span className="detail-label">Patient Name</span>
                                    <span className="detail-value">{currentInc.visit?.client?.fullName || 'Unknown'}</span>
                                </div>
                            </div>

                            <div className="sos-form">
                                <label>{COORDINATOR_SOS.FORM.INCIDENT_LOG}</label>
                                <textarea
                                    value={log}
                                    onChange={(e) => setLog(e.target.value)}
                                    placeholder="Detail immediate actions taken, police involvement, or clinical triage..."
                                />
                                <button
                                    onClick={handleResolve}
                                    disabled={isResolving || currentInc.status === 'investigating' || currentInc.status === 'resolved'}
                                    style={{ opacity: (isResolving || currentInc.status === 'investigating' || currentInc.status === 'resolved') ? 0.7 : 1 }}
                                >
                                    {isResolving ? 'TRANSMITTING...' : (ButtonRegistry.find(b => b.id === 'btn-coord-sos-ack-v2')?.label || COORDINATOR_SOS.FORM.RESOLVE_BTN)}
                                </button>
                                {currentInc.status === 'investigating' && (
                                    <p style={{ marginTop: '10px', color: '#f59e0b', fontSize: '0.875rem' }}>
                                        {COORDINATOR_SOS.MESSAGES.LOCK_WARNING}
                                    </p>
                                )}
                            </div>

                            {/* EMERGENCY DISPATCH SECTION */}
                            {currentInc.status === 'open' && (
                                <div className="emergency-dispatch" style={{ marginTop: '20px', padding: '15px', border: '1px solid #fee2e2', borderRadius: '8px', backgroundColor: '#fef2f2' }}>
                                    <h4 style={{ color: '#991b1b', marginBottom: '10px' }}>Dispatch Emergency Replacement</h4>
                                    <select
                                        value={selectedPsw}
                                        onChange={(e) => setSelectedPsw(e.target.value)}
                                        style={{ width: '100%', padding: '8px', borderRadius: '4px', border: '1px solid #ef4444', marginBottom: '10px' }}
                                    >
                                        <option value="">-- Select Replacement Caregiver --</option>
                                        {psws.map(p => (
                                            <option key={p.id} value={p.id}>{p.fullName} ({p.email})</option>
                                        ))}
                                    </select>
                                    <button
                                        onClick={handleDispatch}
                                        disabled={isDispatching || !selectedPsw}
                                        className="pc-button danger"
                                        style={{ width: '100%', backgroundColor: '#ef4444', color: 'white', border: 'none', padding: '10px', borderRadius: '6px', fontWeight: 600, cursor: 'pointer' }}
                                    >
                                        {isDispatching ? 'DISPATCHING...' : 'INITIALIZE EMERGENCY DISPATCH'}
                                    </button>
                                </div>
                            )}
                        </>
                    )}
                </section>

                <section className="history-card">
                    <h2 style={{ fontSize: '1.25rem', fontWeight: 800, marginBottom: '1.5rem', color: '#1e293b' }}>{COORDINATOR_SOS.ALERTS_TITLE}</h2>
                    <div className="history-list">
                        {incidents.length === 0 ? (
                            <p style={{ color: '#64748b' }}>No recent alerts found.</p>
                        ) : (
                            incidents.map(inc => (
                                <div
                                    key={inc.id}
                                    className={`history-item ${inc.id === activeIncident?.id ? 'active' : ''}`}
                                    onClick={() => setActiveIncident(inc)}
                                    style={{ cursor: 'pointer', padding: '15px', borderRadius: '8px', marginBottom: '10px', border: inc.id === activeIncident?.id ? '2px solid #ef4444' : '1px solid #e2e8f0' }}
                                >
                                    <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
                                        <span style={{ fontWeight: 700 }}>{inc.visit?.psw?.fullName || 'Internal Hub'}</span>
                                        <span className={`pc-badge ${inc.status === 'open' ? 'danger' : inc.status === 'investigating' ? 'warning' : 'success'}`}>
                                            {inc.status.toUpperCase()}
                                        </span>
                                    </div>
                                    <p style={{ fontSize: '0.875rem', color: '#64748b', margin: 0 }}>{inc.description}</p>
                                </div>
                            ))
                        )}
                    </div>
                </section>
            </div>
        </div>
    );
}
