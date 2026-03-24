import React from 'react';

/**
 * LiveIndicator — Shows real-time data status on homes
 *
 * Displays a pulsing green dot when data is live-updating,
 * with optional last-updated timestamp and streaming badge.
 *
 * Usage:
 *   <LiveIndicator isLive={isLive} lastUpdated={lastUpdated} />
 *   <LiveIndicator isLive={isLive} isStreaming={isStreaming} />
 */

interface LiveIndicatorProps {
    isLive: boolean;
    isStreaming?: boolean;
    lastUpdated?: Date | null;
    size?: 'sm' | 'md';
}

export function LiveIndicator({ isLive, isStreaming, lastUpdated, size = 'sm' }: LiveIndicatorProps) {
    const dotSize = size === 'sm' ? '8px' : '10px';
    const fontSize = size === 'sm' ? '0.7rem' : '0.8rem';

    const formatTime = (date: Date | null | undefined): string => {
        if (!date) return '';
        const now = new Date();
        const diffMs = now.getTime() - date.getTime();
        const diffSec = Math.round(diffMs / 1000);
        if (diffSec < 5) return 'just now';
        if (diffSec < 60) return `${diffSec}s ago`;
        const diffMin = Math.round(diffSec / 60);
        return `${diffMin}m ago`;
    };

    return (
        <span
            data-cy="live-indicator"
            style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: '6px',
                padding: '2px 10px',
                borderRadius: '999px',
                backgroundColor: isLive ? 'rgba(34, 197, 94, 0.1)' : 'rgba(156, 163, 175, 0.1)',
                border: `1px solid ${isLive ? 'rgba(34, 197, 94, 0.3)' : 'rgba(156, 163, 175, 0.3)'}`,
                fontSize,
                color: isLive ? '#16a34a' : '#6b7280',
                fontWeight: 600,
                letterSpacing: '0.02em',
                transition: 'all 0.3s ease',
            }}
        >
            {/* Pulsing dot */}
            <span style={{
                width: dotSize,
                height: dotSize,
                borderRadius: '50%',
                backgroundColor: isLive ? '#22c55e' : '#9ca3af',
                boxShadow: isLive ? '0 0 6px rgba(34, 197, 94, 0.6)' : 'none',
                animation: isLive ? 'pulse-live 2s ease-in-out infinite' : 'none',
            }} />

            {isStreaming ? 'STREAMING' : isLive ? 'LIVE' : 'PAUSED'}

            {lastUpdated && (
                <span style={{ opacity: 0.6, fontSize: '0.65rem' }}>
                    {formatTime(lastUpdated)}
                </span>
            )}

            {/* Keyframe animation (inline via style tag) */}
            <style>{`
                @keyframes pulse-live {
                    0%, 100% { opacity: 1; transform: scale(1); }
                    50% { opacity: 0.5; transform: scale(0.85); }
                }
            `}</style>
        </span>
    );
}

export default LiveIndicator;
