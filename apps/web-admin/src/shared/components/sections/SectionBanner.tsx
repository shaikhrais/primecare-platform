// ================================================================
// SectionBanner — Hero banner with gradient background,
// progress bar, and CTA buttons. Replaces old SetupBanner.
// ================================================================
import React from 'react';

export interface SectionBannerProps {
    title: string;
    subtitle?: string;
    progress?: number;
    progressLabel?: string;
    actions?: { label: string; variant?: 'primary' | 'ghost' }[];
    gradient?: string;
}

export const SectionBanner: React.FC<SectionBannerProps> = ({
    title, subtitle, progress, progressLabel, actions, gradient
}) => {
    const bg = gradient || 'linear-gradient(135deg, #004d40 0%, #00695c 100%)';

    return (
        <div style={{ display: 'grid', gridTemplateColumns: progress !== undefined ? '1fr 300px' : '1fr', gap: '1.5rem', marginBottom: '1rem' }}>
            <div style={{
                background: bg, padding: '2rem', borderRadius: '1rem', color: 'white',
                display: 'flex', justifyContent: 'space-between', alignItems: 'center',
                boxShadow: '0 10px 15px -3px rgba(0,0,0,0.1)',
            }}>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 800, margin: '0 0 0.5rem 0' }}>{title}</h2>
                    {subtitle && <p style={{ opacity: 0.9, margin: 0 }}>{subtitle}</p>}
                </div>
                {actions && (
                    <div style={{ display: 'flex', gap: '1rem' }}>
                        {actions.map((a, i) => (
                            <button key={i} className="btn" style={{
                                padding: '0.75rem 1.5rem', fontWeight: 'bold', borderRadius: '0.75rem', cursor: 'pointer',
                                ...(a.variant === 'ghost'
                                    ? { background: 'rgba(255,255,255,0.1)', color: 'white', border: '1px solid rgba(255,255,255,0.2)' }
                                    : { background: 'white', color: '#004d40', border: 'none' }),
                            }}>{a.label}</button>
                        ))}
                    </div>
                )}
            </div>
            {progress !== undefined && (
                <div style={{ background: 'white', padding: '1.5rem', borderRadius: '1rem', border: '1px solid #e5e7eb', display: 'flex', flexDirection: 'column', justifyContent: 'center' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.75rem' }}>
                        <span style={{ fontWeight: 700, fontSize: '0.875rem' }}>{progressLabel || 'Progress'}</span>
                        <span style={{ fontWeight: 800, color: '#4f46e5' }}>{progress}%</span>
                    </div>
                    <div style={{ width: '100%', height: '10px', background: '#f3f4f6', borderRadius: '5px', overflow: 'hidden' }}>
                        <div style={{ width: `${progress}%`, height: '100%', background: 'linear-gradient(90deg, #4f46e5, #7c3aed)', transition: 'width 0.5s ease-out' }} />
                    </div>
                </div>
            )}
        </div>
    );
};
