import React, { useState } from 'react';
import { WifiOff, Wifi, WifiHigh, WifiLow, CloudOff, RefreshCw, UploadCloud, FileText, Server } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { useOfflineSync, PendingMutation } from '@/shared/context/OfflineSyncContext';

export const OfflineIndicator: React.FC = () => {
    const { t } = useTranslation();
    const { isOnline, connectionType, pendingMutations, isSyncing, retrySync, lowBandwidthMode, setLowBandwidthMode } = useOfflineSync();
    const [expanded, setExpanded] = useState(false);

    const getIcon = () => {
        if (!isOnline) return <WifiOff size={18} color="#ef4444" />;
        if (connectionType === '4g') return <Wifi size={18} color="#10b981" />;
        if (connectionType === '3g') return <WifiHigh size={18} color="#f59e0b" />;
        if (connectionType === '2g' || connectionType === 'slow-2g') return <WifiLow size={18} color="#f97316" />;
        return <Wifi size={18} color="#10b981" />;
    };

    const getStatusText = () => {
        if (!isOnline) return 'Offline';
        if (connectionType === '4g') return '4G / LTE';
        if (connectionType === '3g') return '3G';
        return 'Poor Connection';
    };

    // If online and 4G with no pending queues, we can just hide it or show a tiny bubble.
    // For PSW role ergonomics, a persistent network pip could be useful, but let's hide if perfect
    // to avoid clutter, UNLESS there's a queue.
    if (isOnline && connectionType === '4g' && pendingMutations.length === 0) return null;

    return (
        <div style={{
            position: 'fixed',
            bottom: '5rem', // Above bottom nav
            right: '1rem', // Moved to right side to act as a HUD widget
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'flex-end',
            gap: '8px',
            zIndex: 9999,
        }} data-cy="offline-indicator-hud">

            {/* Sync Queue & Network Panel */}
            {expanded && (
                <div style={{
                    backgroundColor: '#1E293B',
                    color: 'white',
                    padding: '16px',
                    borderRadius: '16px',
                    boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.4)',
                    width: '300px',
                    border: '1px solid #334155'
                }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '12px', paddingBottom: '12px', borderBottom: '1px solid #334155' }}>
                        <h4 style={{ margin: 0, fontSize: '0.9rem', display: 'flex', alignItems: 'center', gap: '8px' }}>
                            <Server size={16} /> Connection Controls
                        </h4>
                    </div>

                    <label style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px', fontSize: '0.85rem', cursor: 'pointer' }}>
                        <input data-cy="input-shared.offline-indicator-0"
                            type="checkbox"
                            checked={lowBandwidthMode}
                            onChange={(e) => setLowBandwidthMode(e.target.checked)}
                            style={{ width: '16px', height: '16px' }}
                        />
                        Data Saver Mode (Deactivate Media)
                    </label>

                    {pendingMutations.length > 0 && (
                        <>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '12px' }}>
                                <h4 style={{ margin: 0, fontSize: '0.85rem', display: 'flex', alignItems: 'center', gap: '8px', color: '#94A3B8' }}>
                                    <UploadCloud size={14} /> Sync Queue
                                </h4>
                                <span style={{ backgroundColor: '#ef4444', padding: '2px 8px', borderRadius: '12px', fontSize: '0.75rem', fontWeight: 700 }}>
                                    {pendingMutations.length} Pending
                                </span>
                            </div>
                            <div style={{ maxHeight: '150px', overflowY: 'auto', display: 'flex', flexDirection: 'column', gap: '8px' }}>
                                {pendingMutations.map((m: PendingMutation) => (
                                    <div key={m.id} style={{ display: 'flex', alignItems: 'flex-start', gap: '8px', padding: '8px', backgroundColor: '#0F172A', borderRadius: '8px', fontSize: '0.8rem' }}>
                                        <FileText size={14} color="#94A3B8" style={{ marginTop: '2px' }} />
                                        <div>
                                            <div style={{ fontWeight: 600 }}>{m.description}</div>
                                            <div style={{ fontSize: '0.7rem', color: '#64748B' }}>
                                                {new Date(m.timestamp).toLocaleTimeString()}
                                            </div>
                                        </div>
                                    </div>
                                ))}
                            </div>
                            {isOnline && (
                                <button data-cy="btn-shared.offline-indicator-0"
                                    onClick={retrySync}
                                    disabled={isSyncing}
                                    style={{
                                        width: '100%',
                                        marginTop: '12px',
                                        padding: '10px',
                                        backgroundColor: '#10b981',
                                        color: 'white',
                                        border: 'none',
                                        borderRadius: '8px',
                                        fontWeight: 600,
                                        cursor: 'pointer',
                                        display: 'flex',
                                        justifyContent: 'center',
                                        alignItems: 'center',
                                        gap: '8px'
                                    }}
                                >
                                    {isSyncing ? <RefreshCw size={16} className="spin" /> : <RefreshCw size={16} />}
                                    {isSyncing ? 'Syncing...' : 'Force Sync Now'}
                                </button>
                            )}
                        </>
                    )}
                </div>
            )}

            {/* Network Pill */}
            <div
                onClick={() => setExpanded(!expanded)}
                style={{
                    backgroundColor: !isOnline ? '#ef4444' : (connectionType === '4g' ? '#0F172A' : '#1E293B'),
                    color: 'white',
                    padding: '8px 16px',
                    borderRadius: '9999px',
                    boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.2)',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '8px',
                    fontWeight: 'bold',
                    fontSize: '0.8rem',
                    cursor: 'pointer',
                    border: '1px solid rgba(255,255,255,0.1)'
                }}
            >
                {getIcon()}
                <span>{getStatusText()}</span>

                {pendingMutations.length > 0 && (
                    <div style={{
                        marginLeft: '8px',
                        paddingLeft: '12px',
                        borderLeft: '1px solid rgba(255,255,255,0.2)',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '6px',
                        color: '#f59e0b'
                    }}>
                        <CloudOff size={14} />
                        <span>{pendingMutations.length}</span>
                    </div>
                )}
            </div>
            <style>{`
                .spin { animation: spin 1s linear infinite; }
                @keyframes spin { 100% { transform: rotate(360deg); } }
            `}</style>
        </div>
    );
};

export default OfflineIndicator;
