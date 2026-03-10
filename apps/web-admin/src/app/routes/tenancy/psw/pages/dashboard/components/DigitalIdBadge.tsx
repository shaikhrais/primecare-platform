import React from 'react';
import { X, ShieldCheck, Download } from 'lucide-react';

interface DigitalIdBadgeProps {
    onClose: () => void;
    pswName: string;
    pswRole: string;
    agencyName: string;
}

export const DigitalIdBadge: React.FC<DigitalIdBadgeProps> = ({ onClose, pswName, pswRole, agencyName }) => {
    return (
        <div style={{ position: 'fixed', inset: 0, zIndex: 99999, display: 'flex', alignItems: 'center', justifyContent: 'center', backgroundColor: 'rgba(0,0,0,0.85)', padding: '20px', backdropFilter: 'blur(5px)' }}>
            <div style={{
                backgroundColor: '#FFFFFF', borderRadius: '24px', width: '100%', maxWidth: '380px',
                overflow: 'hidden', display: 'flex', flexDirection: 'column',
                boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.5)'
            }}>
                {/* Header Strip */}
                <div style={{ backgroundColor: '#0F172A', padding: '24px 24px 64px 24px', position: 'relative', textAlign: 'center' }}>
                    <button onClick={onClose} style={{ position: 'absolute', top: '16px', right: '16px', border: 'none', background: 'rgba(255,255,255,0.2)', borderRadius: '50%', padding: '6px', color: 'white', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                        <X size={20} />
                    </button>
                    <ShieldCheck size={40} color="#10B981" style={{ marginBottom: '12px' }} />
                    <h2 style={{ margin: 0, color: 'white', fontSize: '1.4rem', fontWeight: 900, letterSpacing: '1px' }}>VERIFIED PROVIDER</h2>
                    <p style={{ margin: '4px 0 0 0', color: '#94A3B8', fontSize: '0.9rem' }}>{agencyName}</p>
                </div>

                {/* Profile Overlap */}
                <div style={{ position: 'relative', marginTop: '-50px', display: 'flex', justifyContent: 'center' }}>
                    <div style={{ width: '100px', height: '100px', borderRadius: '50%', backgroundColor: '#E2E8F0', border: '4px solid white', overflow: 'hidden', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2.5rem' }}>
                        🏥
                    </div>
                </div>

                {/* Body Details */}
                <div style={{ padding: '20px 24px 32px 24px', textAlign: 'center' }}>
                    <h3 style={{ margin: '0 0 4px 0', fontSize: '1.8rem', fontWeight: 900, color: '#111827' }}>{pswName}</h3>
                    <p style={{ margin: 0, color: '#4F46E5', fontWeight: 700, fontSize: '1.1rem', letterSpacing: '0.5px' }}>{pswRole}</p>

                    <div style={{ margin: '24px auto', width: '180px', height: '180px', backgroundColor: '#F8FAFC', padding: '12px', borderRadius: '16px', border: '1px solid #E2E8F0' }}>
                        {/* Mock QR Code Pattern */}
                        <div style={{ width: '100%', height: '100%', backgroundImage: 'url("data:image/svg+xml,%3Csvg width=\'20\' height=\'20\' viewBox=\'0 0 20 20\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cpath d=\'M0 0h5v5H0V0zm2 2v1h1V2H2zm8-2h10v5H10V0zm2 2v1h6V2h-6zM0 15h5v5H0v-5zm2 2v1h1v-1H2zm8-2h10v5H10v-5zm2 2v1h6v-1h-6zM5 5h10v10H5V5zm2 2v6h6V7H7z\' fill=\'%230F172A\' fill-opacity=\'1\' fill-rule=\'evenodd\'/%3E%3C/svg%3E")', backgroundSize: '10px 10px' }} />
                    </div>

                    <div style={{ padding: '12px', backgroundColor: '#ECFDF5', borderRadius: '12px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px', color: '#059669', fontWeight: 700, fontSize: '0.9rem' }}>
                        <ShieldCheck size={18} /> Credentials Active & Valid
                    </div>
                </div>
            </div>

            <button style={{ position: 'absolute', bottom: '40px', left: '50%', transform: 'translateX(-50%)', padding: '12px 24px', backgroundColor: 'rgba(255,255,255,0.2)', border: '1px solid rgba(255,255,255,0.4)', borderRadius: '24px', color: 'white', fontWeight: 600, display: 'flex', alignItems: 'center', gap: '8px', cursor: 'pointer' }}>
                <Download size={18} /> Save for Offline Use
            </button>
        </div>
    );
};
