import React, { useState } from 'react';
import { ContentRegistry, ApiRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import './SosCenter.css';

const { COORDINATOR_SOS } = ContentRegistry;

export default function SosCenter() {
    const [log, setLog] = useState('');
    const [isResolving, setIsResolving] = useState(false);

    const handleResolve = async () => {
        setIsResolving(true);
        try {
            await apiClient.post(ApiRegistry.COORDINATOR.SOS_ACK, { log, status: 'resolved' });
            alert('SOS Incident Resolved and Archived.');
            setLog('');
        } catch (error) {
            console.error('Failed to resolve SOS:', error);
        } finally {
            setIsResolving(false);
        }
    };

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
                    <div className="emergency-marker">
                        <span className="marker-dot"></span>
                        <h2 className="sos-title">Active SOS Trigger: PSW Elena</h2>
                    </div>

                    <div className="incident-details">
                        <div className="detail-row">
                            <span className="detail-label">Location</span>
                            <span className="detail-value">456 Oak Ave, North York</span>
                        </div>
                        <div className="detail-row">
                            <span className="detail-label">Trigger Time</span>
                            <span className="detail-value">14:00:22 (4m ago)</span>
                        </div>
                        <div className="detail-row">
                            <span className="detail-label">Patient Name</span>
                            <span className="detail-value">Sarah Jenkins</span>
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
                            disabled={isResolving}
                            style={{ opacity: isResolving ? 0.7 : 1 }}
                        >
                            {isResolving ? 'TRANSMITTING...' : COORDINATOR_SOS.FORM.RESOLVE_BTN}
                        </button>
                    </div>
                </section>

                <section className="history-card">
                    <h2 style={{ fontSize: '1.25rem', fontWeight: 800, marginBottom: '1.5rem', color: '#1e293b' }}>{COORDINATOR_SOS.ALERTS_TITLE}</h2>
                    <div className="history-item">
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
                            <span style={{ fontWeight: 700 }}>PSW Mike - Fall Reported</span>
                            <span className="pc-badge success">RESOLVED</span>
                        </div>
                        <p style={{ fontSize: '0.875rem', color: '#64748b' }}>Handled by Coordinator Alex. Clinic backup sent to 123 Main St.</p>
                    </div>
                    <div className="history-item">
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
                            <span style={{ fontWeight: 700 }}>PSW Jane - GPS Signal Lost</span>
                            <span className="pc-badge info">INVESTIGATED</span>
                        </div>
                        <p style={{ fontSize: '0.875rem', color: '#64748b' }}>Verified as dead zone in basement. Session resumed normally.</p>
                    </div>
                </section>
            </div>
        </div>
    );
}
