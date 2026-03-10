import React from 'react';
import { User, Heart, ShieldCheck } from 'lucide-react';

interface WhosComingCardProps {
    workerName: string;
    workerRole: string;
    arrivalTime: string;
    imageUrl?: string;
    bio: string;
}

export const WhosComingCard: React.FC<WhosComingCardProps> = ({ workerName, workerRole, arrivalTime, imageUrl, bio }) => {

    return (
        <section style={{ backgroundColor: 'white', borderRadius: '16px', border: '2px solid #E2E8F0', padding: '32px', display: 'flex', flexDirection: 'column', gap: '24px', boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.1)' }}>
            <h2 style={{ fontSize: '2rem', fontWeight: 900, color: '#0F172A', margin: 0 }}>Who's Coming?</h2>
            
            <div style={{ display: 'flex', gap: '32px', alignItems: 'flex-start', flexWrap: 'wrap' }}>
                {/* Massive Trust Photo */}
                <div style={{ 
                    width: '180px', 
                    height: '180px', 
                    borderRadius: '50%', 
                    backgroundColor: '#F1F5F9', 
                    display: 'flex', alignItems: 'center', justifyContent: 'center',
                    border: '4px solid #3B82F6',
                    overflow: 'hidden',
                    flexShrink: 0
                }}>
                    {imageUrl ? (
                        <img src={imageUrl} alt={workerName} style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
                    ) : (
                        <User size={80} color="#94A3B8" />
                    )}
                </div>

                {/* Identity & Bio */}
                <div style={{ flex: 1, minWidth: '300px' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '8px' }}>
                        <h3 style={{ fontSize: '2.5rem', fontWeight: 900, color: '#0F172A', margin: 0, lineHeight: 1 }}>{workerName}</h3>
                        <ShieldCheck size={32} color="#10B981" title="Background Checked & Verified" />
                    </div>
                    
                    <div style={{ fontSize: '1.25rem', color: '#3B82F6', fontWeight: 800, marginBottom: '24px' }}>
                        {workerRole}
                    </div>

                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px', backgroundColor: '#F0FDFA', border: '2px solid #5EEAD4', padding: '16px 24px', borderRadius: '12px', marginBottom: '24px' }}>
                        <span style={{ fontSize: '1.2rem', fontWeight: 800, color: '#0F766E' }}>Arriving Around:</span>
                        <span style={{ fontSize: '1.5rem', fontWeight: 900, color: '#0F172A' }}>{arrivalTime}</span>
                    </div>

                    <p style={{ fontSize: '1.2rem', color: '#475569', lineHeight: '1.6', margin: 0, backgroundColor: '#F8FAFC', padding: '24px', borderRadius: '12px', border: '1px solid #E2E8F0', fontStyle: 'italic' }}>
                        "{bio}"
                    </p>
                </div>
            </div>
            
            <div style={{ marginTop: '16px', display: 'flex', alignItems: 'center', gap: '12px', color: '#64748B', fontWeight: 700, fontSize: '1rem' }}>
                <Heart size={20} color="#EF4444" fill="#EF4444" />
                <span>{workerName} has completed 124 visits with PrimeCare.</span>
            </div>
        </section>
    );
};
