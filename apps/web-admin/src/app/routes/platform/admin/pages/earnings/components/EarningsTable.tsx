import React from 'react';
import { EarningRecord } from '../earnings.data';

interface EarningsTableProps {
    earnings: EarningRecord[];
}

export const EarningsTable: React.FC<EarningsTableProps> = ({ earnings }) => {
    return (
        <div style={{
            backgroundColor: '#FFFFFF',
            borderRadius: '24px',
            boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.05)',
            overflow: 'hidden',
            border: '1px solid #F3F4F6'
        }}>
            <div style={{ overflowX: 'auto' }}>
                <table data-cy="table-admin.earnings-table" style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                    <thead style={{ backgroundColor: '#F9FAFB', borderBottom: '1px solid #F3F4F6' }}>
                        <tr>
                            {['Invoice ID', 'Date', 'Shift ID', 'Client', 'PSW', 'Revenue', 'Profit', 'Status', 'Actions'].map(header => (
                                <th key={header} style={{ padding: '20px', color: '#6B7280', fontSize: '0.8rem', fontWeight: 800, textTransform: 'uppercase' }}>{header}</th>
                            ))}
                        </tr>
                    </thead>
                    <tbody>
                        {earnings.length > 0 ? earnings.map(record => (
                            <tr key={record.id} style={{ borderBottom: '1px solid #F3F4F6' }}>
                                <td style={{ padding: '20px', fontWeight: 800 }}>{record.id}</td>
                                <td style={{ padding: '20px', fontWeight: 700 }}>{record.date}</td>
                                <td style={{ padding: '20px', color: '#00875A', fontWeight: 800 }}>{record.shiftId}</td>
                                <td style={{ padding: '20px', fontWeight: 700 }}>{record.client}</td>
                                <td style={{ padding: '20px', fontWeight: 700 }}>{record.psw}</td>
                                <td style={{ padding: '20px', fontWeight: 900 }}>${record.revenue.toFixed(2)}</td>
                                <td style={{ padding: '20px', fontWeight: 900, color: '#00875A' }}>${record.profit.toFixed(2)}</td>
                                <td style={{ padding: '20px' }}>
                                    <span style={{
                                        padding: '6px 12px',
                                        borderRadius: '20px',
                                        fontSize: '0.75rem',
                                        fontWeight: 900,
                                        backgroundColor: record.paymentStatus === 'Paid' ? '#E6F4EF' : '#FEE2E2',
                                        color: record.paymentStatus === 'Paid' ? '#00875A' : '#B91C1C'
                                    }}>{record.paymentStatus}</span>
                                </td>
                                <td style={{ padding: '20px' }}>
                                    <button data-cy="btn-admin.earnings-table-0" style={{ padding: '8px 12px', background: '#F3F4F6', border: 'none', borderRadius: '8px', cursor: 'pointer', fontWeight: 700 }}>View Details</button>
                                </td>
                            </tr>
                        )) : (
                            <tr>
                                <td colSpan={9} style={{ padding: '40px', textAlign: 'center', color: '#6B7280' }}>
                                    No earnings records found matching your filters.
                                </td>
                            </tr>
                        )}
                    </tbody>
                </table>
            </div>
        </div>
    );
};
