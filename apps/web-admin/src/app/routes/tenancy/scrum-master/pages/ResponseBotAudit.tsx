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
    label?: string;
    path: string;
    status: 'OK' | '404' | 'WARNING' | 'ERROR';
    errorDetail?: string;
    isOverridden?: boolean;
    lastChecked: string;
}

export const ResponseBotAudit: React.FC = () => {
    const [touchpoints, setTouchpoints] = useState<Touchpoint[]>([]);
    const [loading, setLoading] = useState(true);
    const [sweeping, setSweeping] = useState(false);
    const [publicUrlBase, setPublicUrlBase] = useState('https://primecare-admin.pages.dev');
    const [editingTp, setEditingTp] = useState<Touchpoint | null>(null);

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

    const handleSweep = async (isPublic: boolean = false) => {
        try {
            setSweeping(true);
            await apiClient.post('/v1/scrum-master/registry/sweep', {
                publicUrlBase: isPublic ? publicUrlBase : undefined
            });
            await fetchTouchpoints();
        } catch (error) {
            console.error('Sweep failed', error);
            alert('Registry sweep failed. Check technical logs.');
        } finally {
            setSweeping(false);
        }
    };

    const handleUpdate = async (id: string, label: string, path: string) => {
        try {
            await apiClient.patch(`/v1/scrum-master/registry/touchpoints/${id}`, { label, path });
            setEditingTp(null);
            await fetchTouchpoints();
        } catch (error) {
            console.error('Update failed', error);
            alert('Failed to update registry entry.');
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
                    <div className="public-url-config">
                        <input
                            type="text"
                            value={publicUrlBase}
                            onChange={(e) => setPublicUrlBase(e.target.value)}
                            placeholder="Public App URL (e.g. https://...)"
                        />
                        <button className="btn-secondary" onClick={() => handleSweep(true)}>Pings Public URL</button>
                    </div>
                </div>
                <button
                    className={`btn-sweep ${sweeping ? 'loading' : ''}`}
                    onClick={() => handleSweep(false)}
                    disabled={sweeping}
                >
                    {sweeping ? 'Sweeping Registries...' : '🚀 Registry Internal Sweep'}
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
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {touchpoints.map((tp) => {
                            const statusClass = tp.status === '404' ? 'notfound' : tp.status.toLowerCase();
                            return (
                                <tr key={tp.id} className={`status-${statusClass} ${tp.isOverridden ? 'is-overridden' : ''}`}>
                                    <td className="font-mono text-xs">{tp.touchpointId}</td>
                                    <td><span className={`badge badge-${tp.type.toLowerCase()}`}>{tp.type}</span></td>
                                    <td>
                                        <div className="role-module">
                                            <span className="role">{tp.role}</span>
                                            <span className="module">{tp.module}</span>
                                        </div>
                                    </td>
                                    <td className="path-cell" title={tp.path}>
                                        <div className="label-path">
                                            <span className="tp-label">{tp.label}</span>
                                            <span className="tp-path">{tp.path}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div className="status-cell">
                                            <span className={`status-dot ${statusClass}`}></span>
                                            {tp.status}
                                            {tp.errorDetail && <span className="error-hint" title={tp.errorDetail}>⚠️</span>}
                                        </div>
                                    </td>
                                    <td>
                                        <button className="btn-edit-tp" onClick={() => setEditingTp(tp)}>✎ Edit</button>
                                    </td>
                                </tr>
                            );
                        })}
                    </tbody>
                </table>
            </div>

            {editingTp && (
                <div className="tp-modal-overlay">
                    <div className="tp-modal">
                        <h3>Update Touchpoint</h3>
                        <div className="form-group">
                            <label>Display Label</label>
                            <input
                                type="text"
                                defaultValue={editingTp.label}
                                id="edit-label"
                            />
                        </div>
                        <div className="form-group">
                            <label>Target Path (API/Route)</label>
                            <input
                                type="text"
                                defaultValue={editingTp.path}
                                id="edit-path"
                            />
                        </div>
                        <div className="modal-actions">
                            <button className="btn-primary" onClick={() => {
                                const l = (document.getElementById('edit-label') as HTMLInputElement).value;
                                const p = (document.getElementById('edit-path') as HTMLInputElement).value;
                                handleUpdate(editingTp.id, l, p);
                            }}>Save Override</button>
                            <button className="btn-ghost" onClick={() => setEditingTp(null)}>Cancel</button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default ResponseBotAudit;
