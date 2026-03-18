import React, { useState, useMemo } from 'react';

export interface TableColumn {
    key: string;
    label: string;
    align?: 'left' | 'center' | 'right';
    render?: (value: any, row: Record<string, any>) => React.ReactNode;
}

interface SectionTableProps {
    columns: TableColumn[];
    rows: Record<string, any>[];
    emptyMsg?: string;
}

/** 
 * Central Advanced Grid Wrapper (Native Vanilla React).
 * Built without 3rd party components to ensure pristine dependency trees.
 * Inherits Global Search Input, Striped Rows, and Interactive Row Vectors safely.
 */
export function SectionTable({ columns, rows, emptyMsg }: SectionTableProps) {
    const [searchQuery, setSearchQuery] = useState('');
    const [selectedRowIndex, setSelectedRowIndex] = useState<number | null>(null);

    // Native Search Filtering Algorithm
    const filteredRows = useMemo(() => {
        if (!searchQuery.trim()) return rows;
        const lowerQuery = searchQuery.toLowerCase();
        return rows.filter(row => {
            return columns.some(col => {
                const val = row[col.key];
                if (val == null) return false;
                return String(val).toLowerCase().includes(lowerQuery);
            });
        });
    }, [rows, columns, searchQuery]);

    const renderHeader = () => (
        <div style={{ display: 'flex', justifyContent: 'flex-end', alignItems: 'center', padding: '1rem', borderBottom: '1px solid var(--pc-border-primary, #e5e7eb)', background: 'var(--pc-surface-card, #ffffff)' }}>
            <div style={{ position: 'relative', width: '280px' }}>
                <span style={{ position: 'absolute', left: '0.75rem', top: '50%', transform: 'translateY(-50%)', color: 'var(--text-secondary)' }}>🔍</span>
                <input 
                    type="text" 
                    value={searchQuery} 
                    onChange={(e) => setSearchQuery(e.target.value)} 
                    placeholder="Live Keyword Search..." 
                    style={{ 
                        width: '100%', boxSizing: 'border-box', padding: '0.6rem 0.6rem 0.6rem 2.5rem', 
                        borderRadius: '0.5rem', border: '1px solid var(--border-color, #cbd5e1)', 
                        fontFamily: 'inherit', fontSize: '0.875rem' 
                    }}
                />
            </div>
        </div>
    );

    const renderActions = () => (
        <div style={{ display: 'flex', gap: '0.5rem' }}>
            <button title="View Record" style={{ background: '#ffffff', border: '1px solid var(--border-color, #cbd5e1)', borderRadius: '0.375rem', width: '30px', height: '30px', cursor: 'pointer', color: 'var(--text-secondary, #64748b)', display: 'inline-flex', alignItems: 'center', justifyContent: 'center', transition: 'all 0.2s' }}
                onMouseEnter={e => { e.currentTarget.style.color = 'var(--accent-success, #10b981)'; e.currentTarget.style.borderColor = 'var(--accent-success, #10b981)'; e.currentTarget.style.background = '#f0fdf4'; }}
                onMouseLeave={e => { e.currentTarget.style.color = 'var(--text-secondary, #64748b)'; e.currentTarget.style.borderColor = 'var(--border-color, #cbd5e1)'; e.currentTarget.style.background = '#ffffff'; }}>
                <span>👁️</span> {/* Fallback if Phosphor fails to load in React */}
            </button>
            <button title="Edit Record" style={{ background: '#ffffff', border: '1px solid var(--border-color, #cbd5e1)', borderRadius: '0.375rem', width: '30px', height: '30px', cursor: 'pointer', color: 'var(--text-secondary, #64748b)', display: 'inline-flex', alignItems: 'center', justifyContent: 'center', transition: 'all 0.2s' }}
                onMouseEnter={e => { e.currentTarget.style.color = 'var(--accent-primary, #0ea5e9)'; e.currentTarget.style.borderColor = 'var(--accent-primary, #0ea5e9)'; e.currentTarget.style.background = '#f0f9ff'; }}
                onMouseLeave={e => { e.currentTarget.style.color = 'var(--text-secondary, #64748b)'; e.currentTarget.style.borderColor = 'var(--border-color, #cbd5e1)'; e.currentTarget.style.background = '#ffffff'; }}>
                <span>✏️</span>
            </button>
            <button title="Archive Record" style={{ background: '#ffffff', border: '1px solid var(--border-color, #cbd5e1)', borderRadius: '0.375rem', width: '30px', height: '30px', cursor: 'pointer', color: 'var(--text-secondary, #64748b)', display: 'inline-flex', alignItems: 'center', justifyContent: 'center', transition: 'all 0.2s' }}
                onMouseEnter={e => { e.currentTarget.style.color = 'var(--accent-warning, #f59e0b)'; e.currentTarget.style.borderColor = 'var(--accent-warning, #f59e0b)'; e.currentTarget.style.background = '#fff1f2'; }}
                onMouseLeave={e => { e.currentTarget.style.color = 'var(--text-secondary, #64748b)'; e.currentTarget.style.borderColor = 'var(--border-color, #cbd5e1)'; e.currentTarget.style.background = '#ffffff'; }}>
                <span>🗑️</span>
            </button>
        </div>
    );

    if (!rows.length) {
        return (
            <div style={{ padding: '40px', textAlign: 'center', color: 'var(--text-secondary, #64748b)', background: 'var(--surface-color, #ffffff)', borderRadius: '1rem', border: '1px dashed var(--border-color, #e2e8f0)', marginBottom: '24px' }}>
                <div style={{ fontSize: '2.5rem', marginBottom: '1rem', color: '#cbd5e1' }}>📭</div>
                <div style={{ fontWeight: 600 }}>{emptyMsg || 'No matrix data allocated'}</div>
            </div>
        );
    }

    return (
        <div style={{ borderRadius: '1rem', border: '1px solid var(--border-color, #e2e8f0)', overflow: 'hidden', marginBottom: '24px', background: 'var(--surface-color, #ffffff)', boxShadow: '0 4px 6px -1px rgba(0,0,0,0.05)' }}>
            {renderHeader()}
            
            {filteredRows.length === 0 ? (
                <div style={{ padding: '2rem', textAlign: 'center', color: 'var(--text-secondary, #64748b)' }}>No records maching your search.</div>
            ) : (
                <div style={{ overflowX: 'auto' }}>
                    <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                        <thead>
                            <tr>
                                {columns.map(col => (
                                    <th key={col.key} style={{ padding: '1rem 1.5rem', color: 'var(--text-secondary, #64748b)', fontWeight: 600, fontSize: '0.75rem', textTransform: 'uppercase', letterSpacing: '0.05em', borderBottom: '2px solid var(--border-color, #e2e8f0)', background: '#f8fafc' }}>
                                        {col.label}
                                    </th>
                                ))}
                                <th style={{ padding: '1rem 1.5rem', color: 'var(--text-secondary, #64748b)', fontWeight: 600, fontSize: '0.75rem', textTransform: 'uppercase', letterSpacing: '0.05em', borderBottom: '2px solid var(--border-color, #e2e8f0)', background: '#f8fafc', width: '150px' }}>
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            {filteredRows.map((row, i) => {
                                const isSelected = selectedRowIndex === i;
                                const isEven = i % 2 === 1;
                                
                                return (
                                    <tr key={i} 
                                        onClick={() => setSelectedRowIndex(isSelected ? null : i)}
                                        style={{ 
                                            background: isSelected ? 'rgba(14, 165, 233, 0.08)' : (isEven ? 'rgba(0, 0, 0, 0.015)' : '#ffffff'), 
                                            cursor: 'pointer',
                                            transition: 'background-color 0.2s'
                                        }}
                                        onMouseEnter={e => { if (!isSelected) e.currentTarget.style.background = 'rgba(14, 165, 233, 0.04)'; }}
                                        onMouseLeave={e => { if (!isSelected) e.currentTarget.style.background = isEven ? 'rgba(0, 0, 0, 0.015)' : '#ffffff'; }}
                                    >
                                        {columns.map((col, cIndex) => (
                                            <td key={col.key} style={{ 
                                                padding: '1rem 1.5rem', 
                                                borderBottom: '1px solid var(--border-color, #e2e8f0)',
                                                borderLeft: (cIndex === 0 && isSelected) ? '3px solid var(--accent-primary, #0ea5e9)' : (cIndex === 0 ? '3px solid transparent' : 'none'),
                                                color: 'var(--text-primary, #0f172a)'
                                            }}>
                                                {col.render ? col.render(row[col.key], row) : (row[col.key] ?? '—')}
                                            </td>
                                        ))}
                                        <td style={{ padding: '1rem 1.5rem', borderBottom: '1px solid var(--border-color, #e2e8f0)' }}>
                                            {renderActions()}
                                        </td>
                                    </tr>
                                );
                            })}
                        </tbody>
                    </table>
                </div>
            )}
        </div>
    );
}
