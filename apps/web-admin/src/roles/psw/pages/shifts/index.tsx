import React, { useState } from 'react';
import { Breadcrumb } from '../../components/Breadcrumb';
import { SecureSessionGuard } from '../../components/SecureSessionGuard';

interface Shift {
    id: string;
    date: string;
    time: string;
    pswName: string;
    clientName: string;
    address: string;
    status: 'Scheduled' | 'Completed' | 'Missed' | 'Cancelled';
}

const MOCK_SHIFTS: Shift[] = [
    { id: 'SH-001', date: '2026-02-13', time: '08:00 AM - 12:00 PM', pswName: 'You', clientName: 'Margaret W.', address: '123 Care Street, Toronto', status: 'Scheduled' },
    { id: 'SH-002', date: '2026-02-13', time: '01:00 PM - 05:00 PM', pswName: 'You', clientName: 'Robert B.', address: '456 Health Ave, Toronto', status: 'Scheduled' },
    { id: 'SH-003', date: '2026-02-12', time: '09:00 AM - 01:00 PM', pswName: 'You', clientName: 'Alice J.', address: '789 Aid Blvd, Toronto', status: 'Completed' },
];

export default function ShiftsPage() {
    const [searchTerm, setSearchTerm] = useState('');
    const [statusFilter, setStatusFilter] = useState('All');

    const filteredShifts = MOCK_SHIFTS.filter(shift => {
        const matchesSearch = shift.clientName.toLowerCase().includes(searchTerm.toLowerCase()) ||
            shift.id.toLowerCase().includes(searchTerm.toLowerCase());
        const matchesStatus = statusFilter === 'All' || shift.status === statusFilter;
        return matchesSearch && matchesStatus;
    });

    return (
        <SecureSessionGuard allowedRoles={['psw', 'admin']}>
            <div style={{ padding: '2rem', display: 'flex', flexDirection: 'column', gap: '2rem', animation: 'fadeIn 0.5s ease-out' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', flexWrap: 'wrap', gap: '1rem' }}>
                    <div style={{ flex: 1, minWidth: '300px' }}>
                        <Breadcrumb />
                        <h1 style={{ margin: '0.5rem 0 0 0', fontSize: '2.5rem', fontWeight: 900, color: '#111827' }}>Shifts</h1>
                        <p style={{ margin: '4px 0 0 0', color: '#6B7280', fontWeight: 500 }}>Manage your schedule and visit history</p>
                    </div>

                    <div style={{ display: 'flex', gap: '12px' }}>
                        <button style={{ padding: '12px 20px', backgroundColor: '#F3F4F6', border: '1px solid #E5E7EB', borderRadius: '12px', fontWeight: 700, cursor: 'pointer' }}>
                            📅 Filter Date
                        </button>
                        <button style={{ padding: '12px 24px', backgroundColor: '#00875A', color: 'white', border: 'none', borderRadius: '12px', fontWeight: 800, cursor: 'pointer', boxShadow: '0 4px 14px 0 rgba(0, 135, 90, 0.3)' }}>
                            + Create Shift
                        </button>
                    </div>
                </div>

                {/* --- FILTER BAR --- */}
                <div style={{
                    display: 'flex',
                    gap: '1.5rem',
                    padding: '20px',
                    backgroundColor: '#FFFFFF',
                    borderRadius: '20px',
                    boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)',
                    flexWrap: 'wrap',
                    alignItems: 'center'
                }}>
                    <div style={{ flex: 1, minWidth: '250px', position: 'relative' }}>
                        <input
                            type="text"
                            placeholder="Search by Client or ID..."
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                borderRadius: '12px',
                                border: '1px solid #E5E7EB',
                                fontSize: '1rem',
                                outline: 'none',
                                transition: 'border-color 0.2s'
                            }}
                        />
                    </div>
                    <div style={{ display: 'flex', gap: '8px' }}>
                        {['All', 'Scheduled', 'Completed', 'Cancelled'].map(status => (
                            <button
                                key={status}
                                onClick={() => setStatusFilter(status)}
                                style={{
                                    padding: '10px 16px',
                                    borderRadius: '10px',
                                    border: '1px solid',
                                    borderColor: statusFilter === status ? '#00875A' : '#E5E7EB',
                                    backgroundColor: statusFilter === status ? '#E6F4EF' : '#FFFFFF',
                                    color: statusFilter === status ? '#00875A' : '#6B7280',
                                    fontWeight: 800,
                                    fontSize: '0.85rem',
                                    cursor: 'pointer',
                                    transition: 'all 0.2s'
                                }}
                            >
                                {status}
                            </button>
                        ))}
                    </div>
                </div>

                {/* --- DATA BOARD --- */}
                <div style={{
                    backgroundColor: '#FFFFFF',
                    borderRadius: '24px',
                    boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.05)',
                    overflow: 'hidden',
                    border: '1px solid #F3F4F6'
                }}>
                    <div style={{ overflowX: 'auto' }}>
                        <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                            <thead style={{ backgroundColor: '#F9FAFB', borderBottom: '1px solid #F3F4F6' }}>
                                <tr>
                                    {['Shift ID', 'Date & Time', 'Client', 'Location', 'Status', 'Actions'].map(header => (
                                        <th key={header} style={{ padding: '20px', color: '#6B7280', fontSize: '0.8rem', fontWeight: 800, textTransform: 'uppercase', letterSpacing: '0.5px' }}>
                                            {header}
                                        </th>
                                    ))}
                                </tr>
                            </thead>
                            <tbody>
                                {filteredShifts.map((shift, idx) => (
                                    <tr key={shift.id} style={{
                                        borderBottom: idx === filteredShifts.length - 1 ? 'none' : '1px solid #F3F4F6',
                                        transition: 'background-color 0.1s',
                                        cursor: 'pointer'
                                    }}>
                                        <td style={{ padding: '20px', fontWeight: 800, color: '#00875A' }}>{shift.id}</td>
                                        <td style={{ padding: '20px' }}>
                                            <div style={{ fontWeight: 700, color: '#111827' }}>{shift.date}</div>
                                            <div style={{ fontSize: '0.85rem', color: '#6B7280' }}>{shift.time}</div>
                                        </td>
                                        <td style={{ padding: '20px', fontWeight: 700 }}>{shift.clientName}</td>
                                        <td style={{ padding: '20px', color: '#6B7280', fontSize: '0.9rem', maxWidth: '200px', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                                            {shift.address}
                                        </td>
                                        <td style={{ padding: '20px' }}>
                                            <span style={{
                                                padding: '6px 12px',
                                                borderRadius: '20px',
                                                fontSize: '0.75rem',
                                                fontWeight: 900,
                                                backgroundColor: shift.status === 'Completed' ? '#E6F4EF' : shift.status === 'Scheduled' ? '#E0F2FE' : '#FEE2E2',
                                                color: shift.status === 'Completed' ? '#00875A' : shift.status === 'Scheduled' ? '#0369A1' : '#B91C1C',
                                                textTransform: 'uppercase'
                                            }}>
                                                {shift.status}
                                            </span>
                                        </td>
                                        <td style={{ padding: '20px' }}>
                                            <div style={{ display: 'flex', gap: '8px' }}>
                                                <button style={{ padding: '8px 12px', background: '#F3F4F6', border: 'none', borderRadius: '8px', cursor: 'pointer', fontWeight: 700 }}>Edit</button>
                                                <button style={{ padding: '8px 12px', background: '#000000', color: 'white', border: 'none', borderRadius: '8px', cursor: 'pointer', fontWeight: 700 }}>View</button>
                                            </div>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                    {filteredShifts.length === 0 && (
                        <div style={{ padding: '60px', textAlign: 'center' }}>
                            <div style={{ fontSize: '3rem', marginBottom: '1rem' }}>🔍</div>
                            <h3 style={{ margin: 0, fontWeight: 800 }}>No shifts found</h3>
                            <p style={{ color: '#6B7280', margin: '4px 0 0 0' }}>Try adjusting your search or filters</p>
                        </div>
                    )}
                    <div style={{ padding: '16px 20px', backgroundColor: '#F9FAFB', borderTop: '1px solid #F3F4F6', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <span style={{ fontSize: '0.9rem', color: '#6B7280', fontWeight: 600 }}>Showing {filteredShifts.length} shifts</span>
                        <div style={{ display: 'flex', gap: '8px' }}>
                            <button style={{ padding: '8px 16px', background: 'white', border: '1px solid #E5E7EB', borderRadius: '8px', cursor: 'pointer', fontWeight: 700 }}>Previous</button>
                            <button style={{ padding: '8px 16px', background: 'white', border: '1px solid #E5E7EB', borderRadius: '8px', cursor: 'pointer', fontWeight: 700 }}>Next</button>
                        </div>
                    </div>
                </div>
            </div>

            <style>{`
                    @keyframes fadeIn {
                        from { opacity: 0; transform: translateY(10px); }
                        to { opacity: 1; transform: translateY(0); }
                    }
                    tr:hover {
                        background-color: #F9FAFB;
                    }
                `}</style>
        </SecureSessionGuard >
    );
}

