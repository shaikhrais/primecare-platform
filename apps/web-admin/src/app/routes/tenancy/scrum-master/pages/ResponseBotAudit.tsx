import React, { useEffect, useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import './ResponseBotAudit.css';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

interface Touchpoint {
    id: string;
    touchpointId: string;
    type: 'BUTTON' | 'LINK' | 'INTERACTION';
    role: string;
    module: string;
    path: string;
    status: 'OK' | '404' | 'WARNING' | 'ERROR';
    errorDetail?: string;
    lastChecked: string;
}

export const ResponseBotAudit: React.FC = () => {
    const [touchpoints, setTouchpoints] = useState<Touchpoint[]>([]);
    const [loading, setLoading] = useState(true);
    const [sweeping, setSweeping] = useState(false);

    useEffect(() => {
        fetchTouchpoints();
    }, []);

    const fetchTouchpoints = async () => {
        try {
            setLoading(true);
            const data: any = await apiClient.get('/v1/scrum-master/registry/touchpoints');
            if (Array.isArray(data)) {
                setTouchpoints(data);
            }
        } catch (error) {
            console.error('Failed to load touchpoints', error);
        } finally {
            setLoading(false);
        }
    };

    const handleSweep = async () => {
        try {
            setSweeping(true);
            await apiClient.post('/v1/scrum-master/registry/sweep', {});
            await fetchTouchpoints();
        } catch (error) {
            console.error('Sweep failed', error);
            alert('Registry sweep failed. Check technical logs.');
        } finally {
            setSweeping(false);
        }
    };

    if (loading && touchpoints.length === 0) {
        return <div className="audit-loading">Initializing Response Bot Heartbeat...</div>;
    }

    const errorCount = touchpoints.filter(t => t.status !== 'OK').length;

    return (
        <div className="audit-page">
            <header className="audit-header">
                <div>
                    <h1>Response Bot AI Audit</h1>
                    <p className="subtitle">Autonomous Registry Persistence & 404 Surveillance</p>
                </div>
                <button
                    className={`btn-sweep ${sweeping ? 'loading' : ''}`}
                    onClick={handleSweep}
                    disabled={sweeping}
                >
                    {sweeping ? 'Sweeping Platform...' : '🚀 Trigger Universal Sweep'}
                </button>
            </header>

            <div className="audit-stats">
                <div className="stat-card">
                    <span className="stat-label">Total Touchpoints</span>
                    <span className="stat-value">{touchpoints.length}</span>
                </div>
                <div className="stat-card warning">
                    <span className="stat-label">Errors Detected</span>
                    <span className="stat-value">{errorCount}</span>
                </div>
                <div className="stat-card success">
                    <span className="stat-label">Platform Health</span>
                    <span className="stat-value">{touchpoints.length > 0 ? Math.round(((touchpoints.length - errorCount) / touchpoints.length) * 100) : 100}%</span>
                </div>
            </div>

            <div className="audit-grid-container">
                <table className="audit-table">
                    <thead>
                        <tr>
                            <th>Touchpoint ID</th>
                            <th>Type</th>
                            <th>Role/Module</th>
                            <th>Path/Action</th>
                            <th>Status</th>
                            <th>Last Checked</th>
                        </tr>
                    </thead>
                    <tbody>
                        {touchpoints.map((tp) => {
                            const statusClass = tp.status === '404' ? 'notfound' : tp.status.toLowerCase();
                            return (
                                <tr key={tp.id} className={`status-${statusClass}`}>
                                    <td className="font-mono text-xs">{tp.touchpointId}</td>
                                    <td><span className={`badge badge-${tp.type.toLowerCase()}`}>{tp.type}</span></td>
                                    <td>
                                        <div className="role-module">
                                            <span className="role">{tp.role}</span>
                                            <span className="module">{tp.module}</span>
                                        </div>
                                    </td>
                                    <td className="path-cell" title={tp.path}>{tp.path}</td>
                                    <td>
                                        <div className="status-cell">
                                            <span className={`status-dot ${statusClass}`}></span>
                                            {tp.status}
                                            {tp.errorDetail && <span className="error-hint" title={tp.errorDetail}>⚠️</span>}
                                        </div>
                                    </td>
                                    <td className="text-xs opacity-60">{new Date(tp.lastChecked).toLocaleString()}</td>
                                </tr>
                            );
                        })}
                    </tbody>
                </table>
            </div>
        </div>
    );
};

export default ResponseBotAudit;
