import React from 'react';
import { LiveIndicator } from '../ui/LiveIndicator';

interface SectionHeaderProps {
    title: string;
    subtitle?: string;
    isLive?: boolean;
    lastUpdated?: Date;
    dataCy?: string;
}

/** Standard page header with title, subtitle, and optional live indicator */
export function SectionHeader({ title, subtitle, isLive, lastUpdated, dataCy }: SectionHeaderProps) {
    return (
        <div style={{ marginBottom: '1.5rem' }}>
            <h1 data-cy={dataCy || 'page.title'} style={{
                margin: '0 0 6px 0', fontSize: '1.75rem', fontWeight: 800,
                color: 'var(--pc-text-primary, var(--text))',
            }}>
                {title}
            </h1>
            {subtitle && (
                <p data-cy="page.subtitle" style={{
                    margin: 0, color: 'var(--pc-text-tertiary, rgba(0,0,0,0.5))',
                    fontSize: '0.85rem', display: 'flex', alignItems: 'center', gap: '8px',
                }}>
                    {subtitle}
                    {isLive !== undefined && <LiveIndicator isLive={isLive} lastUpdated={lastUpdated} />}
                </p>
            )}
        </div>
    );
}
