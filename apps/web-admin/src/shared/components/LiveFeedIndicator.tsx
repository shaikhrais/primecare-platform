import React from 'react';
import { useLiveKPI } from '@/shared/hooks/useLiveKPI';

/**
 * LiveFeedIndicator — Shows real-time connection status + event ticker
 * 
 * Displays a pulsing green dot when connected, with the latest event scrolling
 * as a ticker. Designed for dashboard headers.
 */
export const LiveFeedIndicator: React.FC<{ compact?: boolean }> = ({ compact = false }) => {
    const { lastEvent, isConnected, connectionStatus, events } = useLiveKPI();

    const statusColor = {
        connected: 'var(--pc-success)',
        connecting: 'var(--pc-warning)',
        reconnecting: 'var(--pc-warning)',
        disconnected: 'var(--pc-text-tertiary)'
    }[connectionStatus];

    const statusLabel = {
        connected: 'Live',
        connecting: 'Connecting...',
        reconnecting: 'Reconnecting...',
        disconnected: 'Offline'
    }[connectionStatus];

    const eventIcon: Record<string, string> = {
        VISIT_STARTED: '🏠',
        VISIT_COMPLETED: '✅',
        INCIDENT_CREATED: '🚨',
        SHIFT_ASSIGNED: '📋',
        CHECK_IN: '📍',
        CHECK_OUT: '👋',
        INVOICE_PAID: '💰',
        ALERT: '⚠️',
    };

    if (compact) {
        return (
            <div
                data-cy="live-feed-indicator"
                style={{
                    display: 'flex', alignItems: 'center', gap: '6px',
                    padding: '4px 10px', borderRadius: '20px',
                    backgroundColor: 'var(--pc-bg-secondary)',
                    fontSize: '0.75rem', fontWeight: 600,
                    color: statusColor,
                    border: `1px solid ${isConnected ? 'var(--pc-success)' : 'var(--pc-border-primary)'}`,
                }}
            >
                <span style={{
                    width: '8px', height: '8px', borderRadius: '50%',
                    backgroundColor: statusColor,
                    animation: isConnected ? 'pulse 2s infinite' : 'none',
                    flexShrink: 0,
                }} />
                {statusLabel}
            </div>
        );
    }

    return (
        <div
            data-cy="live-feed-panel"
            style={{
                backgroundColor: 'var(--pc-surface-card)',
                border: '1px solid var(--pc-border-primary)',
                borderRadius: 'var(--pc-radius-lg)',
                padding: '16px 20px',
                marginBottom: '1.5rem',
            }}
        >
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '12px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                    <span style={{
                        width: '10px', height: '10px', borderRadius: '50%',
                        backgroundColor: statusColor,
                        animation: isConnected ? 'pulse 2s infinite' : 'none',
                        boxShadow: isConnected ? `0 0 8px ${statusColor}` : 'none',
                    }} />
                    <span style={{ fontWeight: 700, fontSize: '0.9rem', color: 'var(--pc-text-primary)' }}>
                        Live Activity Feed
                    </span>
                    <span style={{
                        fontSize: '0.65rem', fontWeight: 600, color: statusColor,
                        backgroundColor: 'var(--pc-bg-secondary)',
                        padding: '2px 8px', borderRadius: '10px',
                    }}>
                        {statusLabel}
                    </span>
                </div>
                <span style={{ fontSize: '0.75rem', color: 'var(--pc-text-tertiary)' }}>
                    {events.length} events
                </span>
            </div>

            {events.length === 0 ? (
                <div style={{
                    textAlign: 'center', padding: '20px', color: 'var(--pc-text-tertiary)',
                    fontSize: '0.85rem',
                }}>
                    {isConnected
                        ? '⏳ Waiting for events...'
                        : '🔌 Connect to see live updates'}
                </div>
            ) : (
                <div style={{
                    display: 'flex', flexDirection: 'column', gap: '6px',
                    maxHeight: '180px', overflowY: 'auto',
                }}>
                    {events.slice(0, 8).map((evt, i) => (
                        <div
                            key={`${evt.timestamp}-${i}`}
                            style={{
                                display: 'flex', alignItems: 'center', gap: '10px',
                                padding: '8px 12px', borderRadius: 'var(--pc-radius-md)',
                                backgroundColor: i === 0 ? 'var(--pc-success-bg)' : 'var(--pc-bg-secondary)',
                                transition: 'background-color 0.3s ease',
                                fontSize: '0.8rem',
                            }}
                        >
                            <span style={{ fontSize: '1rem', flexShrink: 0 }}>
                                {eventIcon[evt.type] || '📡'}
                            </span>
                            <div style={{ flex: 1, minWidth: 0 }}>
                                <span style={{
                                    fontWeight: i === 0 ? 700 : 500,
                                    color: 'var(--pc-text-primary)',
                                }}>
                                    {evt.type.replace(/_/g, ' ')}
                                </span>
                                {evt.data?.clientName && (
                                    <span style={{ color: 'var(--pc-text-secondary)', marginLeft: '6px' }}>
                                        — {evt.data.clientName}
                                    </span>
                                )}
                            </div>
                            <span style={{
                                fontSize: '0.68rem', color: 'var(--pc-text-tertiary)',
                                whiteSpace: 'nowrap', flexShrink: 0,
                            }}>
                                {new Date(evt.timestamp).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', second: '2-digit' })}
                            </span>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
};
