import React from 'react';
import { ShieldAlert } from 'lucide-react';
import { useAuth } from '@/shared/context/AuthContext';

export const ImpersonationBanner: React.FC = () => {
    // In a real application, you'd pull this from a global auth/tenant state
    // e.g. const { isImpersonating, spoofedTenantName, stopImpersonation } = useAuth();
    
    // For demonstration, we assume it's always true when this component is rendered manually
    const isImpersonating = true; 
    const spoofedTenantName = "PrimeCare - East York Region";

    if (!isImpersonating) return null;

    return (
        <div style={{
            position: 'fixed',
            top: 0,
            left: 0,
            right: 0,
            height: '40px',
            background: 'repeating-linear-gradient(45deg, #F59E0B, #F59E0B 10px, #D97706 10px, #D97706 20px)',
            zIndex: 10000,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            color: 'white',
            fontWeight: 800,
            textTransform: 'uppercase',
            letterSpacing: '1px',
            fontSize: '0.85rem',
            boxShadow: '0 4px 6px -1px rgba(0,0,0,0.3)',
            animation: 'slide-down 0.3s ease-out'
        }}>
            
            <div style={{ display: 'flex', alignItems: 'center', gap: '12px', backgroundColor: '#0F172A', padding: '4px 24px', borderRadius: '4px', border: '2px solid #FEF3C7' }}>
                <ShieldAlert size={18} color="#F59E0B" />
                <span>HAZARD: You are currently mutating foreign data. Spoofing Tenant: </span>
                <span style={{ color: '#FCD34D', textDecoration: 'underline' }}>{spoofedTenantName}</span>
                <button 
                    onClick={() => window.location.reload()} // Reload interface
                    style={{ marginLeft: '12px', backgroundColor: '#DC2626', color: 'white', border: 'none', padding: '4px 12px', borderRadius: '4px', cursor: 'pointer', fontWeight: 800 }}
                >
                    EXIT SPOOF
                </button>
            </div>

            <style>{`
                @keyframes slide-down {
                    from { transform: translateY(-100%); }
                    to { transform: translateY(0); }
                }
            `}</style>
        </div>
    );
};
