import React from 'react';
import { useNavigate } from 'react-router-dom';
import { ChevronRight } from 'lucide-react';
import type { PageType, PageEntry } from 'prime-care-shared';
import { TYPE_META } from './registryMeta';

interface GridViewProps {
    grouped: Record<string, PageEntry[]>;
}

export function GridView({ grouped }: GridViewProps) {
    const navigate = useNavigate();

    return (
        <>
            {Object.entries(grouped).map(([type, pages]) => {
                const meta = TYPE_META[type as PageType]!;
                return (
                    <div key={type} style={{ marginBottom: '32px' }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '14px' }}>
                            <span style={{ display: 'inline-flex', alignItems: 'center', gap: '6px', padding: '4px 12px', borderRadius: '6px', background: meta.bg, color: meta.color, fontWeight: 800, fontSize: '0.8rem', textTransform: 'uppercase' }}>
                                {meta.icon} {meta.label}
                            </span>
                            <span style={{ color: '#94A3B8', fontSize: '0.8rem', fontWeight: 600 }}>{pages.length} pages</span>
                        </div>
                        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))', gap: '12px' }}>
                            {pages.map(page => (
                                <div key={page.id} data-cy={`page-card-${page.categoryCode}`} className="pc-card" onClick={() => navigate(page.route)}
                                    style={{ padding: '16px', cursor: 'pointer', transition: 'all 0.15s', border: '1px solid #E2E8F0', borderLeft: `3px solid ${meta.color}` }}
                                    onMouseEnter={e => { e.currentTarget.style.boxShadow = `0 4px 16px ${meta.bg}`; e.currentTarget.style.borderColor = meta.color; }}
                                    onMouseLeave={e => { e.currentTarget.style.boxShadow = 'none'; e.currentTarget.style.borderColor = '#E2E8F0'; }}>
                                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                                        <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                                            <div style={{ minWidth: '32px', height: '32px', display: 'flex', alignItems: 'center', justifyContent: 'center', borderRadius: '8px', background: '#0F172A', color: 'white', fontWeight: 800, fontSize: '0.75rem', fontFamily: 'monospace' }}>#{page.srNo}</div>
                                            <div>
                                                <div style={{ fontWeight: 700, color: '#0F172A', fontSize: '0.9rem' }}>{page.label}</div>
                                                <div style={{ fontFamily: 'monospace', fontSize: '0.65rem', color: '#94A3B8' }}>{page.route}</div>
                                            </div>
                                        </div>
                                        <ChevronRight size={16} color="#94A3B8" />
                                    </div>
                                    <div style={{ display: 'flex', gap: '6px', marginTop: '10px', flexWrap: 'wrap' }}>
                                        <span style={{ padding: '2px 8px', borderRadius: '4px', fontSize: '0.7rem', fontWeight: 800, fontFamily: 'monospace', background: meta.bg, color: meta.color }}>{page.categoryCode}</span>
                                        <span style={{ padding: '1px 8px', borderRadius: '4px', fontSize: '0.6rem', fontWeight: 700, textTransform: 'uppercase', background: '#F1F5F9', color: '#475569' }}>{page.owner}</span>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                );
            })}
        </>
    );
}
