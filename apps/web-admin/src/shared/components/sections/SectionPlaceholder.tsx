import React from 'react';
import type { PageSection } from 'prime-care-shared';

interface SectionPlaceholderProps {
    section: PageSection;
}

/** Placeholder for planned/mocked sections — shows status and description */
export function SectionPlaceholder({ section }: SectionPlaceholderProps) {
    return (
        <div style={{
            padding: '40px 24px', borderRadius: '14px', textAlign: 'center',
            border: '2px dashed var(--pc-border-primary, #e5e7eb)',
            background: 'var(--pc-bg-secondary, #f9fafb)',
            marginBottom: '24px',
        }}>
            <div style={{ fontSize: '1.5rem', marginBottom: '8px' }}>
                {section.status === 'planned' ? '📋' : '🔧'}
            </div>
            <div style={{ fontWeight: 700, color: 'var(--pc-text-secondary)', marginBottom: '4px' }}>
                {section.label}
            </div>
            <div style={{ fontSize: '0.75rem', color: 'var(--pc-text-tertiary)' }}>
                {section.status === 'planned'
                    ? 'Coming soon — not yet implemented'
                    : section.description || `Section type: ${section.type}`}
            </div>
            <div style={{
                display: 'inline-block', marginTop: '12px',
                padding: '3px 12px', borderRadius: '8px',
                fontSize: '0.65rem', fontWeight: 700, textTransform: 'uppercase',
                color: section.status === 'planned' ? '#7C3AED' : '#f59e0b',
                background: section.status === 'planned' ? 'rgba(124,58,237,0.1)' : 'rgba(245,158,11,0.1)',
            }}>
                {section.status}
            </div>
        </div>
    );
}
