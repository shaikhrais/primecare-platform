import React from 'react';
import type { PageType, MasterEntry } from 'prime-care-shared';
import { AdminRegistry } from 'prime-care-shared';
import { TYPE_META, OWNER_META } from './registryMeta';

const { MASTER_REGISTRY } = AdminRegistry;

interface TableViewProps {
    filteredMaster: Array<{ code: string; label: string; type: string; owner: string; file: string; associates: string[] }>;
}

export function TableView({ filteredMaster }: TableViewProps) {
    return (
        <div className="pc-card" style={{ overflow: 'auto', marginBottom: '32px' }}>
            <table data-cy="page-master-table" style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.8rem' }}>
                <thead>
                    <tr style={{ background: '#F8FAFC', borderBottom: '2px solid #E2E8F0' }}>
                        <th style={{ padding: '10px 12px', textAlign: 'center', fontWeight: 800, color: '#64748B', width: '65px' }}>Code</th>
                        <th style={{ padding: '10px 12px', textAlign: 'left', fontWeight: 800, color: '#64748B' }}>Label</th>
                        <th style={{ padding: '10px 12px', textAlign: 'center', fontWeight: 800, color: '#64748B', width: '90px' }}>Type</th>
                        <th style={{ padding: '10px 12px', textAlign: 'center', fontWeight: 800, color: '#64748B', width: '100px' }}>Owner</th>
                        <th style={{ padding: '10px 12px', textAlign: 'left', fontWeight: 800, color: '#64748B' }}>File</th>
                        <th style={{ padding: '10px 12px', textAlign: 'left', fontWeight: 800, color: '#64748B', width: '200px' }}>Associates</th>
                    </tr>
                </thead>
                <tbody>
                    {filteredMaster.map(entry => {
                        const meta = TYPE_META[entry.type as PageType];
                        return (
                            <tr key={entry.code} data-cy={`master-row-${entry.code}`}
                                style={{ borderBottom: '1px solid #F1F5F9', transition: 'background 0.1s' }}
                                onMouseEnter={e => e.currentTarget.style.background = '#F8FAFC'}
                                onMouseLeave={e => e.currentTarget.style.background = 'transparent'}>
                                <td style={{ padding: '8px 12px', textAlign: 'center' }}>
                                    <span style={{ display: 'inline-block', padding: '2px 8px', borderRadius: '4px', fontWeight: 800, fontSize: '0.75rem', fontFamily: 'monospace', background: meta?.bg || '#F1F5F9', color: meta?.color || '#64748B' }}>{entry.code}</span>
                                </td>
                                <td style={{ padding: '8px 12px', fontWeight: 600, color: '#0F172A' }}>{entry.label}</td>
                                <td style={{ padding: '8px 12px', textAlign: 'center' }}>
                                    <span style={{ padding: '1px 8px', borderRadius: '4px', fontSize: '0.65rem', fontWeight: 700, textTransform: 'uppercase', background: meta?.bg || '#F1F5F9', color: meta?.color || '#64748B' }}>{meta?.label || entry.type}</span>
                                </td>
                                <td style={{ padding: '8px 12px', textAlign: 'center', fontSize: '0.75rem', color: '#475569' }}>{OWNER_META[entry.owner]?.icon || ''} {entry.owner}</td>
                                <td style={{ padding: '8px 12px', fontFamily: 'monospace', fontSize: '0.6rem', color: '#94A3B8', maxWidth: '250px', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>{entry.file.split('/').slice(-2).join('/')}</td>
                                <td style={{ padding: '8px 12px' }}>
                                    <div style={{ display: 'flex', gap: '3px', flexWrap: 'wrap' }}>
                                        {entry.associates.map(a => {
                                            const aEntry = (MASTER_REGISTRY as Record<string, MasterEntry>)?.[a];
                                            const aMeta = aEntry ? TYPE_META[aEntry.type as PageType] : null;
                                            return (<span key={a} style={{ padding: '1px 5px', borderRadius: '3px', fontSize: '0.55rem', fontWeight: 700, fontFamily: 'monospace', background: aMeta?.bg || '#F1F5F9', color: aMeta?.color || '#94A3B8' }} title={aEntry?.label || a}>{a}</span>);
                                        })}
                                    </div>
                                </td>
                            </tr>
                        );
                    })}
                </tbody>
            </table>
        </div>
    );
}
