import React from 'react';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';
import { TableSkeleton } from '@/shared/components/ui/Skeleton';

const PlatformAuditLogs: React.FC = () => {
    // TanStack Query: auto-cached audit logs
    const { data: rawData, isLoading: loading } = useRegistryQuery<any>('/v1/system/platform/audit-logs', {
        queryKey: ['platform', 'audit-logs'],
        staleTime: 30_000,
    });

    const logs = rawData?.logs || [];

    if (loading) return <TableSkeleton rows={5} columns={4} />;

    return (
        <div style={{ padding: '2rem' }}>
            <h1 style={{ marginBottom: '2rem', fontSize: '1.875rem', fontWeight: 'bold', color: '#111827' }}>Global Audit Logs</h1>

            <div style={{ overflowX: 'auto', backgroundColor: '#FFFFFF', borderRadius: '0.75rem', border: '1px solid #E5E7EB' }}>
                <table data-cy="table-index" style={{ minWidth: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                    <thead style={{ backgroundColor: '#F9FAFB', borderBottom: '1px solid #E5E7EB' }}>
                        <tr>
                            <th style={{ padding: '0.75rem 1rem', fontSize: '0.75rem', fontWeight: 'semibold', color: '#4B5563', textTransform: 'uppercase' }}>Tenant</th>
                            <th style={{ padding: '0.75rem 1rem', fontSize: '0.75rem', fontWeight: 'semibold', color: '#4B5563', textTransform: 'uppercase' }}>Action</th>
                            <th style={{ padding: '0.75rem 1rem', fontSize: '0.75rem', fontWeight: 'semibold', color: '#4B5563', textTransform: 'uppercase' }}>Actor</th>
                            <th style={{ padding: '0.75rem 1rem', fontSize: '0.75rem', fontWeight: 'semibold', color: '#4B5563', textTransform: 'uppercase' }}>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        {logs.map((log: any) => (
                            <tr key={log.id} style={{ borderBottom: '1px solid #F3F4F6' }}>
                                <td style={{ padding: '1rem', whiteSpace: 'nowrap' }}>
                                    <span style={{ fontWeight: 'medium', color: '#111827' }}>{log.tenant?.name}</span>
                                    <br />
                                    <span style={{ fontSize: '0.75rem', color: '#6B7280' }}>{log.tenant?.slug}</span>
                                </td>
                                <td style={{ padding: '1rem' }}>
                                    <span style={{ padding: '0.125rem 0.5rem', fontSize: '0.75rem', borderRadius: '9999px', backgroundColor: '#E0F2FE', color: '#0369A1' }}>{log.action}</span>
                                </td>
                                <td style={{ padding: '1rem', color: '#4B5563' }}>{log.actor?.email}</td>
                                <td style={{ padding: '1rem', color: '#6B7280', fontSize: '0.875rem' }}>{new Date(log.createdAt).toLocaleString()}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
};

export default PlatformAuditLogs;
