import React, { useState } from 'react';
import { Car, MapPin, Clock, ShieldCheck } from 'lucide-react';

interface RideRequest {
    patientId: string;
    patientName: string;
    pickupAddress: string;
    dropoffClinic: string;
    appointmentTime: string;
}

export const UberHealthDispatcher: React.FC = () => {
    const [dispatching, setDispatching] = useState(false);
    const [rideStatus, setRideStatus] = useState<'IDLE' | 'DISPATCHED' | 'EN_ROUTE'>('IDLE');

 // patient request
    const sampleRequest: RideRequest = {
        patientId: 'pt_91',
        patientName: 'Eleanor Vance',
        pickupAddress: '142 Evergreen Terrace, Toronto',
        dropoffClinic: 'Mount Sinai Dialysis Center',
        appointmentTime: '14:30'
    };

    const handleDispatch = () => {
        setDispatching(true);
 // hitting the Uber Health B2B API
        setTimeout(() => {
            setDispatching(false);
            setRideStatus('DISPATCHED');
            
 // Driver Accept payload arriving
            setTimeout(() => {
                setRideStatus('EN_ROUTE');
            }, 3000);

        }, 1500);
    };

    return (
        <div style={{ backgroundColor: 'white', borderRadius: '12px', border: '1px solid #E2E8F0', padding: '20px', marginTop: '16px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '20px' }}>
                <div style={{ backgroundColor: 'black', padding: '10px', borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <Car size={20} color="white" />
                </div>
                <div>
                    <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Medical Transport</h3>
                    <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.85rem' }}>Powered by Uber Health API</p>
                </div>
            </div>

            <div style={{ backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '8px', border: '1px solid #E2E8F0', marginBottom: '20px', display: 'flex', flexDirection: 'column', gap: '12px' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <span style={{ fontWeight: 700, color: '#0F172A' }}>{sampleRequest.patientName}</span>
                    <span style={{ fontSize: '0.85rem', color: '#64748B', display: 'flex', alignItems: 'center', gap: '6px' }}><Clock size={14} /> Appt: {sampleRequest.appointmentTime}</span>
                </div>
                
                <div style={{ display: 'flex', alignItems: 'flex-start', gap: '8px' }}>
                    <MapPin size={16} color="#475569" style={{ marginTop: '2px' }} />
                    <div style={{ fontSize: '0.9rem', color: '#334155' }}>
                        <div><strong>Pick-up:</strong> {sampleRequest.pickupAddress}</div>
                        <div style={{ marginTop: '4px' }}><strong>Drop-off:</strong> {sampleRequest.dropoffClinic}</div>
                    </div>
                </div>
            </div>

            {rideStatus === 'IDLE' && (
                <button 
                    onClick={handleDispatch}
                    disabled={dispatching}
                    style={{ 
                        width: '100%', padding: '12px', backgroundColor: 'black', color: 'white', 
                        border: 'none', borderRadius: '8px', fontWeight: 700, fontSize: '1rem', 
                        cursor: dispatching ? 'not-allowed' : 'pointer', display: 'flex', alignItems: 'center', 
                        justifyContent: 'center', gap: '8px', opacity: dispatching ? 0.7 : 1
                    }}
                >
                    {dispatching ? <div className="spinner" /> : <ShieldCheck size={18} />}
                    {dispatching ? 'Calculating Route & Fare...' : 'Dispatch PrimeCare Vehicle'}
                </button>
            )}

            {rideStatus === 'DISPATCHED' && (
                <div style={{ backgroundColor: '#FEF9C3', border: '1px solid #FEF08A', color: '#B45309', padding: '12px', borderRadius: '8px', textAlign: 'center', fontWeight: 600, fontSize: '0.9rem' }}>
                    Scanning nearby HIPAA-certified drivers...
                </div>
            )}

            {rideStatus === 'EN_ROUTE' && (
                <div style={{ backgroundColor: '#F0FDF4', border: '1px solid #BBF7D0', color: '#166534', padding: '12px', borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                        <Car size={18} />
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '0.9rem' }}>Driver En Route</div>
                            <div style={{ fontSize: '0.75rem', opacity: 0.8 }}>Black Honda Civic (ABCD-123)</div>
                        </div>
                    </div>
                    <div style={{ fontWeight: 800 }}>ETA: 4 mins</div>
                </div>
            )}
            <style>{`.spinner { width: 16px; height: 16px; border: 2px solid rgba(255,255,255,0.3); border-radius: 50%; border-top-color: white; animation: spin 1s ease-in-out infinite; } @keyframes spin { to { transform: rotate(360deg); } }`}</style>
        </div>
    );
};
