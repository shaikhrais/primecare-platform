import React from 'react';

interface PcTableColumn<T> {
    key: string;
    header: string;
    render?: (row: T, index: number) => React.ReactNode;
    sortable?: boolean;
    width?: string;
    align?: 'left' | 'center' | 'right';
}

interface PcTableProps<T> {
    columns: PcTableColumn<T>[];
    data: T[];
    loading?: boolean;
    emptyMessage?: string;
    emptyIcon?: string;
    onRowClick?: (row: T, index: number) => void;
    sortColumn?: string;
    sortDirection?: 'asc' | 'desc';
    onSort?: (column: string) => void;
    stickyHeader?: boolean;
    compact?: boolean;
    striped?: boolean;
}

/**
 * PcTable — Standardized data table with sorting, loading skeletons,
 * empty states, row clicks, and dark mode support.
 */
export function PcTable<T extends Record<string, any>>({
    columns, data, loading, emptyMessage = 'No data found', emptyIcon = '📭',
    onRowClick, sortColumn, sortDirection, onSort, stickyHeader, compact, striped,
}: PcTableProps<T>) {
    const cellPadding = compact ? '8px 12px' : '14px 16px';

    if (loading) {
        return (
            <div style={{ borderRadius: 'var(--pc-radius-lg)', border: '1px solid var(--pc-border-primary)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead>
                        <tr>
                            {columns.map(col => (
                                <th key={col.key} style={{
                                    padding: cellPadding, textAlign: col.align || 'left',
                                    background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-tertiary)',
                                    fontSize: '0.7rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.05em',
                                    borderBottom: '1px solid var(--pc-border-primary)', width: col.width,
                                }}>
                                    {col.header}
                                </th>
                            ))}
                        </tr>
                    </thead>
                    <tbody>
                        {Array.from({ length: 5 }).map((_, i) => (
                            <tr key={i}>
                                {columns.map(col => (
                                    <td key={col.key} style={{ padding: cellPadding, borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        <div className="shimmer" style={{
                                            height: '14px', borderRadius: '6px',
                                            width: `${60 + Math.random() * 30}%`,
                                            background: 'var(--pc-bg-secondary)',
                                        }} />
                                    </td>
                                ))}
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        );
    }

    if (data.length === 0) {
        return (
            <div style={{
                textAlign: 'center', padding: '48px 24px',
                borderRadius: 'var(--pc-radius-lg)', border: '1px solid var(--pc-border-primary)',
                background: 'var(--pc-surface-card)',
            }}>
                <div style={{ fontSize: '3rem', marginBottom: '12px' }}>{emptyIcon}</div>
                <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.9rem', margin: 0 }}>{emptyMessage}</p>
            </div>
        );
    }

    return (
        <div style={{ borderRadius: 'var(--pc-radius-lg)', border: '1px solid var(--pc-border-primary)', overflow: 'hidden' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                <thead>
                    <tr>
                        {columns.map(col => (
                            <th
                                key={col.key}
                                onClick={() => col.sortable && onSort?.(col.key)}
                                style={{
                                    padding: cellPadding, textAlign: col.align || 'left',
                                    background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-tertiary)',
                                    fontSize: '0.7rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.05em',
                                    borderBottom: '2px solid var(--pc-border-primary)', width: col.width,
                                    cursor: col.sortable ? 'pointer' : 'default',
                                    userSelect: 'none', whiteSpace: 'nowrap',
                                    position: stickyHeader ? 'sticky' : undefined, top: stickyHeader ? 0 : undefined,
                                    zIndex: stickyHeader ? 10 : undefined,
                                }}
                            >
                                {col.header}
                                {col.sortable && sortColumn === col.key && (
                                    <span style={{ marginLeft: '4px' }}>{sortDirection === 'asc' ? '↑' : '↓'}</span>
                                )}
                            </th>
                        ))}
                    </tr>
                </thead>
                <tbody>
                    {data.map((row, i) => (
                        <tr
                            key={i}
                            onClick={() => onRowClick?.(row, i)}
                            style={{
                                cursor: onRowClick ? 'pointer' : 'default',
                                background: striped && i % 2 === 1 ? 'var(--pc-bg-secondary)' : 'var(--pc-surface-card)',
                                transition: 'background 0.15s ease',
                            }}
                            onMouseEnter={e => { if (onRowClick) e.currentTarget.style.background = 'var(--pc-bg-hover, var(--pc-bg-secondary))'; }}
                            onMouseLeave={e => { e.currentTarget.style.background = striped && i % 2 === 1 ? 'var(--pc-bg-secondary)' : 'var(--pc-surface-card)'; }}
                        >
                            {columns.map(col => (
                                <td key={col.key} style={{
                                    padding: cellPadding, textAlign: col.align || 'left',
                                    borderBottom: '1px solid var(--pc-border-primary)',
                                    fontSize: '0.85rem', color: 'var(--pc-text-primary)',
                                }}>
                                    {col.render ? col.render(row, i) : row[col.key]}
                                </td>
                            ))}
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}
