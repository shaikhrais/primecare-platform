import React, { useState } from 'react';
import { Calendar, Car, Clock, CheckCircle2 } from 'lucide-react';

interface Reservation {
    id: string;
    vehiclePlate: string;
    vehicleModel: string;
    startTime: string;
    endTime: string;
    workerName: string;
    status: 'ACTIVE' | 'UPCOMING' | 'COMPLETED';
}

export const VehicleReservationTable: React.FC = () => {
    const [reservations, setReservations] = useState<Reservation[]>([
        { id: 'res1', vehiclePlate: 'CXTM-902', vehicleModel: '2022 Toyota Prius', startTime: '09:00 AM', endTime: '02:00 PM', workerName: 'Sarah Jenkins', status: 'ACTIVE' },
        { id: 'res2', vehiclePlate: 'BPR-112', vehicleModel: '2021 Ford Escape', startTime: '03:00 PM', endTime: '08:00 PM', workerName: 'You', status: 'UPCOMING' }
    ]);
    
    const [bookingActive, setBookingActive] = useState(false);
    const [selectedVehicle, setSelectedVehicle] = useState<string>('');

    const handleBooking = () => {
        setBookingActive(true);
        setTimeout(() => {
            setReservations(prev => [
                ...prev, 
                { id: `res${Date.now()}`, vehiclePlate: selectedVehicle, vehicleModel: 'Agency Fleet Vehicle', startTime: '10:00 AM (Tomorrow)', endTime: '04:00 PM (Tomorrow)', workerName: 'You', status: 'UPCOMING' }
            ]);
            setBookingActive(false);
            setSelectedVehicle('');
        }, 1200);
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#F0FDF4', padding: '10px', borderRadius: '8px' }}>
                        <Car size={24} color="#16A34A" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Fleet Reservations</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Book an agency vehicle for your rural routes.</p>
                    </div>
                </div>
            </div>

            {/* Quick Booking UI */}
            <div style={{ backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '8px', border: '1px solid #E2E8F0', marginBottom: '24px', display: 'flex', gap: '16px', alignItems: 'flex-end' }}>
                <div style={{ flex: 1 }}>
                    <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 700, color: '#475569', marginBottom: '6px' }}>Select Available Vehicle</label>
                    <select 
                        value={selectedVehicle} 
                        onChange={(e) => setSelectedVehicle(e.target.value)}
                        style={{ padding: '10px', width: '100%', borderRadius: '6px', border: '1px solid #CBD5E1', backgroundColor: 'white' }}
                    >
                        <option value="">-- Choose a car --</option>
                        <option value="YYZ-999">YYZ-999 (2023 Honda CR-V)</option>
                        <option value="TOR-001">TOR-001 (2020 Toyota Corolla)</option>
                    </select>
                </div>
                <div style={{ flex: 1 }}>
                    <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 700, color: '#475569', marginBottom: '6px' }}>Date & Time</label>
                    <input type="text" value="Tomorrow, 10:00 AM - 04:00 PM" disabled style={{ padding: '10px', width: '100%', borderRadius: '6px', border: '1px solid #CBD5E1', backgroundColor: '#F1F5F9', color: '#94A3B8' }} />
                </div>
                <button 
                    onClick={handleBooking}
                    disabled={!selectedVehicle || bookingActive}
                    style={{ 
                        padding: '12px 24px', backgroundColor: '#16A34A', color: 'white', border: 'none', 
                        borderRadius: '6px', fontWeight: 700, cursor: (!selectedVehicle || bookingActive) ? 'not-allowed' : 'pointer',
                        opacity: (!selectedVehicle || bookingActive) ? 0.6 : 1, display: 'flex', alignItems: 'center', gap: '8px'
                    }}
                >
                    {bookingActive ? 'Processing...' : <><Calendar size={18} /> Book Now</>}
                </button>
            </div>

            {/* Existing Reservations Table */}
            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.9rem' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Vehicle</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Reserved By</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Time Window</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Status</th>
                    </tr>
                </thead>
                <tbody>
                    {reservations.map(res => (
                        <tr key={res.id} style={{ borderBottom: '1px solid #E2E8F0', backgroundColor: res.workerName === 'You' ? '#F0F9FF' : 'white' }}>
                            <td style={{ padding: '12px' }}>
                                <div style={{ fontWeight: 700, color: '#0F172A' }}>{res.vehiclePlate}</div>
                                <div style={{ fontSize: '0.8rem', color: '#64748B' }}>{res.vehicleModel}</div>
                            </td>
                            <td style={{ padding: '12px', fontWeight: res.workerName === 'You' ? 800 : 500, color: '#334155' }}>
                                {res.workerName}
                            </td>
                            <td style={{ padding: '12px', color: '#475569' }}>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
                                    <Clock size={12} color="#94A3B8" /> {res.startTime} - {res.endTime}
                                </div>
                            </td>
                            <td style={{ padding: '12px' }}>
                                {res.status === 'ACTIVE' && <span style={{ backgroundColor: '#FEF2F2', color: '#DC2626', padding: '4px 8px', borderRadius: '12px', fontSize: '0.75rem', fontWeight: 700 }}>In Use Now</span>}
                                {res.status === 'UPCOMING' && <span style={{ backgroundColor: '#EFF6FF', color: '#2563EB', padding: '4px 8px', borderRadius: '12px', fontSize: '0.75rem', fontWeight: 700 }}>Upcoming</span>}
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};
