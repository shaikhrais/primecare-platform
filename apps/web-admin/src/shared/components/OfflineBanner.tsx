import React, { useState, useEffect } from 'react';
import { useOfflineSync } from '@/shared/context/OfflineSyncContext';

/**
 * OfflineBanner — Persistent UI indicator that shows connection status,
 * pending mutation count, sync progress, and low-bandwidth warnings.
 *
 * Slides in from the top when offline or when mutations are syncing.
 * Uses CSS variables for dark mode compatibility.
 */
export const OfflineBanner: React.FC = () => {
    const { isOnline, pendingMutations, isSyncing, syncProgress, connectionType, lowBandwidthMode } = useOfflineSync();
    const [dismissed, setDismissed] = useState(false);
    const [showUpdateBanner, setShowUpdateBanner] = useState(false);

    // Listen for SW update-available events
    useEffect(() => {
        if (!('serviceWorker' in navigator)) return;
        navigator.serviceWorker.addEventListener('message', (event) => {
            if (event.data?.type === 'SYNC_COMPLETE') {
                setDismissed(false); // Show banner after sync
            }
        });

        // Check for waiting SW
        navigator.serviceWorker.ready.then((reg) => {
            if (reg.waiting) setShowUpdateBanner(true);
            reg.addEventListener('updatefound', () => {
                const newWorker = reg.installing;
                newWorker?.addEventListener('statechange', () => {
                    if (newWorker.state === 'installed' && navigator.serviceWorker.controller) {
                        setShowUpdateBanner(true);
                    }
                });
            });
        });
    }, []);

    const shouldShow = !isOnline || isSyncing || pendingMutations.length > 0 || lowBandwidthMode || showUpdateBanner;
    if (!shouldShow || dismissed) return null;

    // Offline — red banner
    if (!isOnline) {
        return (
            <div style={bannerStyle('#DC2626', '#FEF2F2')}>
                <div style={innerStyle}>
                    <span style={iconStyle}>📡</span>
                    <div style={{ flex: 1 }}>
                        <strong>You're offline</strong>
                        <span style={subTextStyle}>
                            {pendingMutations.length > 0
                                ? ` • ${pendingMutations.length} change${pendingMutations.length > 1 ? 's' : ''} will sync when reconnected`
                                : ' • Read-only mode — cached data shown'}
                        </span>
                    </div>
                    <button onClick={() => setDismissed(true)} style={closeStyle}>✕</button>
                </div>
            </div>
        );
    }

    // Syncing — blue animated banner
    if (isSyncing) {
        return (
            <div style={bannerStyle('#2563EB', '#EFF6FF')}>
                <div style={innerStyle}>
                    <span style={{ ...iconStyle, animation: 'spin 1s linear infinite' }}>🔄</span>
                    <div style={{ flex: 1 }}>
                        <strong>Syncing offline changes</strong>
                        <span style={subTextStyle}>
                            {` • ${syncProgress.current}/${syncProgress.total} completed`}
                        </span>
                    </div>
                    <div style={{
                        width: '80px', height: '4px', borderRadius: '2px',
                        background: 'rgba(37,99,235,0.2)', overflow: 'hidden',
                    }}>
                        <div style={{
                            width: `${(syncProgress.current / (syncProgress.total || 1)) * 100}%`,
                            height: '100%', background: '#2563EB', borderRadius: '2px',
                            transition: 'width 0.5s ease',
                        }} />
                    </div>
                </div>
            </div>
        );
    }

    // Pending mutations — amber banner
    if (pendingMutations.length > 0) {
        return (
            <div style={bannerStyle('#F59E0B', '#FFFBEB')}>
                <div style={innerStyle}>
                    <span style={iconStyle}>⏳</span>
                    <div style={{ flex: 1 }}>
                        <strong>{pendingMutations.length} pending change{pendingMutations.length > 1 ? 's' : ''}</strong>
                        <span style={subTextStyle}> • Will sync automatically</span>
                    </div>
                    <button onClick={() => setDismissed(true)} style={closeStyle}>✕</button>
                </div>
            </div>
        );
    }

    // Low bandwidth — subtle yellow
    if (lowBandwidthMode) {
        return (
            <div style={bannerStyle('#F59E0B', '#FFFBEB')}>
                <div style={innerStyle}>
                    <span style={iconStyle}>🐢</span>
                    <div style={{ flex: 1 }}>
                        <strong>Low bandwidth ({connectionType})</strong>
                        <span style={subTextStyle}> • Images and animations reduced</span>
                    </div>
                    <button onClick={() => setDismissed(true)} style={closeStyle}>✕</button>
                </div>
            </div>
        );
    }

    // SW update available
    if (showUpdateBanner) {
        return (
            <div style={bannerStyle('#7C3AED', '#F5F3FF')}>
                <div style={innerStyle}>
                    <span style={iconStyle}>🆕</span>
                    <div style={{ flex: 1 }}>
                        <strong>Update available</strong>
                        <span style={subTextStyle}> • A new version of PrimeCare is ready</span>
                    </div>
                    <button
                        onClick={() => { navigator.serviceWorker.controller?.postMessage({ type: 'SKIP_WAITING' }); window.location.reload(); }}
                        style={{
                            padding: '4px 12px', borderRadius: '6px', border: 'none',
                            background: '#7C3AED', color: 'white', fontWeight: 700,
                            fontSize: '0.75rem', cursor: 'pointer',
                        }}
                    >
                        Update Now
                    </button>
                </div>
            </div>
        );
    }

    return null;
};

// ── Styles ────────────────────────────────────────────────────────────
const bannerStyle = (accent: string, bg: string): React.CSSProperties => ({
    position: 'fixed', top: 0, left: 0, right: 0, zIndex: 99999,
    background: bg, borderBottom: `2px solid ${accent}`,
    padding: '8px 16px', fontSize: '0.8rem', color: '#1E293B',
    animation: 'slideDown 0.3s ease-out',
});

const innerStyle: React.CSSProperties = {
    display: 'flex', alignItems: 'center', gap: '10px',
    maxWidth: '1200px', margin: '0 auto',
};

const iconStyle: React.CSSProperties = { fontSize: '1.1rem', flexShrink: 0 };
const subTextStyle: React.CSSProperties = { color: '#64748B', fontWeight: 400 };
const closeStyle: React.CSSProperties = {
    background: 'transparent', border: 'none', cursor: 'pointer',
    fontSize: '1rem', color: '#94A3B8', padding: '4px',
};
