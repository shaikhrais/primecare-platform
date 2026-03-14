import React from 'react';
import { Network, ArrowRight, FolderOpen } from 'lucide-react';
import type { PageType, MasterEntry } from 'prime-care-shared';
import { AdminRegistry } from 'prime-care-shared';
import { TYPE_META, OWNER_META } from './registryMeta';

const { MASTER_REGISTRY } = AdminRegistry;

interface IdentityMapViewProps {
    groupedByOwner: Record<string, Array<{ code: string; label: string; type: string; owner: string; file: string; associates: string[] }>>;
    selectedCode: string | null;
    setSelectedCode: (code: string | null) => void;
    selectedEntry: MasterEntry | null;
}

export function IdentityMapView({ groupedByOwner, selectedCode, setSelectedCode, selectedEntry }: IdentityMapViewProps) {
    return (
        <div style={{ display: 'flex', gap: '24px' }}>
            {/* Left: grouped entries */}
            <div style={{ flex: 1 }}>
                {Object.entries(groupedByOwner).sort((a, b) => b[1].length - a[1].length).map(([owner, entries]) => {
                    const ownerMeta = OWNER_META[owner] || { icon: '📄', color: '#64748B', bg: '#F1F5F9' };
                    return (
                        <div key={owner} style={{ marginBottom: '28px' }}>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '12px', padding: '8px 14px', background: ownerMeta.bg, borderRadius: '10px', borderLeft: `4px solid ${ownerMeta.color}` }}>
                                <span style={{ fontSize: '1.2rem' }}>{ownerMeta.icon}</span>
                                <span style={{ fontWeight: 800, color: ownerMeta.color, fontSize: '0.9rem', textTransform: 'uppercase' }}>{owner}</span>
                                <span style={{ fontWeight: 800, fontSize: '0.75rem', color: 'white', background: ownerMeta.color, padding: '2px 8px', borderRadius: '10px' }}>{entries.length}</span>
                            </div>
                            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(340px, 1fr))', gap: '8px' }}>
                                {entries.map(entry => {
                                    const meta = TYPE_META[entry.type as PageType];
                                    const isSelected = selectedCode === entry.code;
                                    return (
                                        <div key={entry.code} data-cy={`identity-card-${entry.code}`} onClick={() => setSelectedCode(isSelected ? null : entry.code)}
                                            style={{ padding: '12px 14px', borderRadius: '10px', border: isSelected ? `2px solid ${meta?.color || '#64748B'}` : '1px solid #E2E8F0', background: isSelected ? (meta?.bg || '#F1F5F9') : 'white', cursor: 'pointer', transition: 'all 0.15s' }}
                                            onMouseEnter={e => { if (!isSelected) e.currentTarget.style.borderColor = meta?.color || '#94A3B8'; }}
                                            onMouseLeave={e => { if (!isSelected) e.currentTarget.style.borderColor = '#E2E8F0'; }}>
                                            <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                                                <span style={{ display: 'inline-flex', alignItems: 'center', justifyContent: 'center', minWidth: '44px', padding: '4px 8px', borderRadius: '8px', fontWeight: 900, fontSize: '0.8rem', fontFamily: 'monospace', background: meta?.bg || '#F1F5F9', color: meta?.color || '#64748B', border: `1px solid ${meta?.color || '#CBD5E1'}20` }}>{entry.code}</span>
                                                <div style={{ flex: 1, minWidth: 0 }}>
                                                    <div style={{ fontWeight: 700, fontSize: '0.85rem', color: '#0F172A' }}>{entry.label}</div>
                                                    <div style={{ fontFamily: 'monospace', fontSize: '0.55rem', color: '#94A3B8', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>{entry.file.split('/').slice(-2).join('/')}</div>
                                                </div>
                                                <span style={{ padding: '2px 7px', borderRadius: '4px', fontSize: '0.55rem', fontWeight: 700, textTransform: 'uppercase', background: meta?.bg || '#F1F5F9', color: meta?.color || '#64748B' }}>{meta?.label || entry.type}</span>
                                            </div>
                                            {entry.associates.length > 0 && (
                                                <div style={{ display: 'flex', gap: '4px', marginTop: '8px', flexWrap: 'wrap', alignItems: 'center' }}>
                                                    <ArrowRight size={10} color="#94A3B8" />
                                                    {entry.associates.map(a => {
                                                        const assocEntry = (MASTER_REGISTRY as Record<string, MasterEntry>)?.[a];
                                                        const assocMeta = assocEntry ? TYPE_META[assocEntry.type as PageType] : null;
                                                        return (
                                                            <span key={a} onClick={e => { e.stopPropagation(); setSelectedCode(a); }}
                                                                style={{ padding: '1px 6px', borderRadius: '4px', fontSize: '0.6rem', fontWeight: 700, fontFamily: 'monospace', background: assocMeta?.bg || '#F1F5F9', color: assocMeta?.color || '#64748B', cursor: 'pointer', border: `1px solid ${assocMeta?.color || '#CBD5E1'}30` }}
                                                                title={assocEntry?.label || a}>{a}</span>
                                                        );
                                                    })}
                                                </div>
                                            )}
                                        </div>
                                    );
                                })}
                            </div>
                        </div>
                    );
                })}
            </div>

            {/* Right: Detail panel */}
            {selectedCode && selectedEntry && (
                <div style={{ width: '340px', flexShrink: 0, position: 'sticky', top: '24px', alignSelf: 'flex-start' }}>
                    <div style={{ padding: '20px', borderRadius: '14px', border: `2px solid ${TYPE_META[selectedEntry.type as PageType]?.color || '#CBD5E1'}`, background: 'white', boxShadow: '0 8px 32px rgba(0,0,0,0.08)' }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '16px' }}>
                            <span style={{ padding: '6px 12px', borderRadius: '10px', fontWeight: 900, fontSize: '1.1rem', fontFamily: 'monospace', background: TYPE_META[selectedEntry.type as PageType]?.bg || '#F1F5F9', color: TYPE_META[selectedEntry.type as PageType]?.color || '#64748B' }}>{selectedCode}</span>
                            <div>
                                <div style={{ fontWeight: 800, fontSize: '1rem', color: '#0F172A' }}>{selectedEntry.label}</div>
                                <div style={{ display: 'flex', gap: '6px', marginTop: '4px' }}>
                                    <span style={{ padding: '1px 6px', borderRadius: '4px', fontSize: '0.6rem', fontWeight: 700, textTransform: 'uppercase', background: TYPE_META[selectedEntry.type as PageType]?.bg || '#F1F5F9', color: TYPE_META[selectedEntry.type as PageType]?.color || '#64748B' }}>{selectedEntry.type}</span>
                                    <span style={{ padding: '1px 6px', borderRadius: '4px', fontSize: '0.6rem', fontWeight: 700, background: OWNER_META[selectedEntry.owner]?.bg || '#F1F5F9', color: OWNER_META[selectedEntry.owner]?.color || '#64748B' }}>{OWNER_META[selectedEntry.owner]?.icon} {selectedEntry.owner}</span>
                                </div>
                            </div>
                        </div>
                        <div style={{ marginBottom: '16px' }}>
                            <div style={{ fontSize: '0.65rem', fontWeight: 700, color: '#64748B', marginBottom: '4px', textTransform: 'uppercase' }}><FolderOpen size={10} style={{ verticalAlign: 'middle', marginRight: '4px' }} /> Source File</div>
                            <div style={{ fontFamily: 'monospace', fontSize: '0.65rem', color: '#475569', padding: '8px 10px', borderRadius: '6px', background: '#F8FAFC', wordBreak: 'break-all', lineHeight: 1.5 }}>{selectedEntry.file}</div>
                        </div>
                        <div>
                            <div style={{ fontSize: '0.65rem', fontWeight: 700, color: '#64748B', marginBottom: '8px', textTransform: 'uppercase' }}><Network size={10} style={{ verticalAlign: 'middle', marginRight: '4px' }} /> Associates ({selectedEntry.associates.length})</div>
                            {selectedEntry.associates.length === 0 ? (
                                <div style={{ color: '#CBD5E1', fontSize: '0.75rem', fontStyle: 'italic' }}>No associates</div>
                            ) : (
                                <div style={{ display: 'flex', flexDirection: 'column', gap: '6px' }}>
                                    {selectedEntry.associates.map(a => {
                                        const assoc = (MASTER_REGISTRY as Record<string, MasterEntry>)?.[a];
                                        const aMeta = assoc ? TYPE_META[assoc.type as PageType] : null;
                                        return (
                                            <div key={a} onClick={() => setSelectedCode(a)}
                                                style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '8px 10px', borderRadius: '8px', border: '1px solid #E2E8F0', cursor: 'pointer', transition: 'all 0.15s' }}
                                                onMouseEnter={e => { e.currentTarget.style.borderColor = aMeta?.color || '#94A3B8'; e.currentTarget.style.background = aMeta?.bg || '#F8FAFC'; }}
                                                onMouseLeave={e => { e.currentTarget.style.borderColor = '#E2E8F0'; e.currentTarget.style.background = 'transparent'; }}>
                                                <span style={{ padding: '2px 8px', borderRadius: '5px', fontWeight: 800, fontSize: '0.7rem', fontFamily: 'monospace', background: aMeta?.bg || '#F1F5F9', color: aMeta?.color || '#64748B' }}>{a}</span>
                                                <div style={{ flex: 1, minWidth: 0 }}><div style={{ fontWeight: 600, fontSize: '0.75rem', color: '#0F172A' }}>{assoc?.label || a}</div></div>
                                                <span style={{ padding: '1px 5px', borderRadius: '3px', fontSize: '0.5rem', fontWeight: 700, textTransform: 'uppercase', background: aMeta?.bg || '#F1F5F9', color: aMeta?.color || '#94A3B8' }}>{assoc?.type || '?'}</span>
                                            </div>
                                        );
                                    })}
                                </div>
                            )}
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
}
