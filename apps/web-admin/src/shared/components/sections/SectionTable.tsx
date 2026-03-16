import React from 'react';

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

/** Standard data table section — used for lists, registries, and audit views */
export function SectionTable({ columns, rows, emptyMsg }: SectionTableProps) {
    if (!rows.length) {
        return (
            <div style={{
                padding: '40px', textAlign: 'center', color: 'var(--pc-text-tertiary)',
                background: 'var(--pc-surface-card, #fff)', borderRadius: '14px',
                border: '1px solid var(--pc-border-primary, #e5e7eb)', marginBottom: '24px',
            }}>
                {emptyMsg || 'No data available'}
            </div>
        );
    }
    return (
        <div style={{
            borderRadius: '14px',
            border: '1px solid var(--pc-border-primary, #e5e7eb)',
            overflow: 'hidden', marginBottom: '24px',
        }}>
            <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                <thead>
                    <tr>
                        {columns.map(col => (
                            <th key={col.key} style={{
                                padding: '12px 16px',
                                textAlign: col.align || 'left',
                                background: 'var(--pc-bg-secondary, #f9fafb)',
                                color: 'var(--pc-text-tertiary)',
                                fontSize: '0.7rem', fontWeight: 700, textTransform: 'uppercase',
                                borderBottom: '2px solid var(--pc-border-primary, #e5e7eb)',
                            }}>
                                {col.label}
                            </th>
                        ))}
                    </tr>
                </thead>
                <tbody>
                    {rows.map((row, i) => (
                        <tr key={i} style={{ background: 'var(--pc-surface-card, #fff)', cursor: 'pointer' }}
                            onMouseEnter={e => e.currentTarget.style.background = 'var(--pc-bg-secondary, #f9fafb)'}
                            onMouseLeave={e => e.currentTarget.style.background = 'var(--pc-surface-card, #fff)'}>
                            {columns.map(col => (
                                <td key={col.key} style={{
                                    padding: '14px 16px',
                                    textAlign: col.align || 'left',
                                    borderBottom: '1px solid var(--pc-border-primary, #e5e7eb)',
                                    color: 'var(--pc-text-primary)',
                                }}>
                                    {col.render ? col.render(row[col.key], row) : (row[col.key] ?? '—')}
                                </td>
                            ))}
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}
