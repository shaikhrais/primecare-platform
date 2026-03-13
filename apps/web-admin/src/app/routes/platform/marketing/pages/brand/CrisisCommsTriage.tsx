import React, { useState } from 'react';
import { ShieldAlert, Send, Users, Building, Newspaper, AlertTriangle, AlertOctagon } from 'lucide-react';

export const CrisisCommsTriage: React.FC = () => {
    const [crisisType, setCrisisType] = useState('SEVERE_WEATHER');
    const [audiences, setAudiences] = useState({
        families: true,
        partners: true,
        media: false
    });
    const [isDeploying, setIsDeploying] = useState(false);
    const [deploymentSuccess, setDeploymentSuccess] = useState(false);

    const handleDeploy = () => {
        setIsDeploying(true);
        setTimeout(() => {
            setIsDeploying(false);
            setDeploymentSuccess(true);
            setTimeout(() => setDeploymentSuccess(false), 5000);
        }, 2000);
    };

    const toggleAudience = (type: keyof typeof audiences) => {
        setAudiences(prev => ({ ...prev, [type]: !prev[type] }));
    };

    const getTemplatePreview = () => {
        switch(crisisType) {
            case 'SEVERE_WEATHER':
                return "URGENT ALER: Due to severe weather conditions (blizzard/hurricane), non-essential clinical visits may be delayed. Our 24/7 triage team is prioritizing life-sustaining care. Your assigned nurse will contact you directly regarding schedule adjustments.";
            case 'PUBLIC_HEALTH':
                return "HEALTH ADVISORY: PrimeCare is enacting enhanced infection control protocols due to a local public health alert. All field clinicians are equipped with Level 3 PPE. Read our full safety update here.";
            case 'DATA_BREACH':
                return "SECURITY NOTICE: PrimeCare has detected a potential data security incident. We have secured our systems and engaged federal cybersecurity experts. We will provide a comprehensive update within 24 hours.";
            default:
                return "";
        }
    };

    return (
        <div style={{ backgroundColor: '#111827', border: '1px solid #374151', borderRadius: '12px', padding: '32px', marginTop: '16px', color: 'white' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#7F1D1D', padding: '16px', borderRadius: '12px', border: '2px solid #DC2626',boxShadow: '0 0 15px rgba(220, 38, 38, 0.5)' }}>
                        <AlertOctagon size={36} color="#FECACA" className="animate-pulse" />
                    </div>
                    <div>
                        <h3 data-cy="h3-crisis-comms-triage-0" style={{ margin: 0, fontSize: '1.8rem', color: '#FCA5A5', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '1px' }}>Global Crisis Communications Triage</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#9CA3AF', fontSize: '0.95rem' }}>DEFCON 1: Rapidly deploy synchronized emergency broadcasts to mitigate brand damage during PR/Operational crises.</p>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '32px' }}>
                <div style={{ flex: 1, backgroundColor: '#1F2937', padding: '24px', borderRadius: '12px', border: '1px solid #4B5563' }}>
                    <h4 style={{ margin: '0 0 16px 0', color: '#E5E7EB', fontSize: '1.1rem', fontWeight: 800 }}>1. Select Incident Type</h4>
                    <select data-cy="select-crisis-comms-triage-0" 
                        value={crisisType} 
                        onChange={(e) => setCrisisType(e.target.value)}
                        style={{ width: '100%', padding: '12px', borderRadius: '8px', backgroundColor: '#374151', color: 'white', border: '1px solid #6B7280', fontSize: '1rem', outline: 'none', marginBottom: '24px' }}
                    >
                        <option value="SEVERE_WEATHER">Level 1: Extreme Weather / Logistics Failure</option>
                        <option value="PUBLIC_HEALTH">Level 2: Local Public Health Emergency</option>
                        <option value="DATA_BREACH">Level 3: Cyber Security / Ransomware Attack</option>
                    </select>

                    <h4 style={{ margin: '0 0 16px 0', color: '#E5E7EB', fontSize: '1.1rem', fontWeight: 800 }}>2. Select Output Channels</h4>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                        <div 
                            onClick={() => toggleAudience('families')}
                            style={{ padding: '16px', borderRadius: '8px', border: `2px solid ${audiences.families ? '#3B82F6' : '#4B5563'}`, backgroundColor: audiences.families ? '#1E3A8A' : '#374151', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '12px', transition: 'all 0.2s' }}
                        >
                            <Users size={20} color={audiences.families ? '#93C5FD' : '#9CA3AF'} />
                            <div style={{ fontWeight: 700, color: audiences.families ? 'white' : '#D1D5DB' }}>Active Patient Families (SMS / App Push)</div>
                        </div>
                        <div 
                            onClick={() => toggleAudience('partners')}
                            style={{ padding: '16px', borderRadius: '8px', border: `2px solid ${audiences.partners ? '#10B981' : '#4B5563'}`, backgroundColor: audiences.partners ? '#064E3B' : '#374151', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '12px', transition: 'all 0.2s' }}
                        >
                            <Building size={20} color={audiences.partners ? '#6EE7B7' : '#9CA3AF'} />
                            <div style={{ fontWeight: 700, color: audiences.partners ? 'white' : '#D1D5DB' }}>B2B Hospital Partners (Email Broadcast)</div>
                        </div>
                        <div 
                            onClick={() => toggleAudience('media')}
                            style={{ padding: '16px', borderRadius: '8px', border: `2px solid ${audiences.media ? '#DC2626' : '#4B5563'}`, backgroundColor: audiences.media ? '#7F1D1D' : '#374151', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '12px', transition: 'all 0.2s' }}
                        >
                            <Newspaper size={20} color={audiences.media ? '#FCA5A5' : '#9CA3AF'} />
                            <div style={{ fontWeight: 700, color: audiences.media ? 'white' : '#D1D5DB' }}>Local Health Media (PR Newswire Sync)</div>
                        </div>
                    </div>
                </div>

                <div style={{ flex: 1, backgroundColor: '#000000', padding: '24px', borderRadius: '12px', border: '1px solid #374151', display: 'flex', flexDirection: 'column' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px', color: '#6B7280', fontSize: '0.85rem', fontWeight: 800, textTransform: 'uppercase', letterSpacing: '2px' }}>
                        <AlertTriangle size={16} color="#DC2626" /> Legal/PR Approved Payload Preview
                    </div>
                    
                    <div style={{ flex: 1, backgroundColor: '#111827', padding: '20px', borderRadius: '8px', border: '1px solid #374151', color: '#E5E7EB', fontSize: '1.05rem', lineHeight: 1.6, fontFamily: 'monospace', whiteSpace: 'pre-wrap' }}>
                        {getTemplatePreview()}
                    </div>

                    {!deploymentSuccess ? (
                         <button data-cy="btn-crisis-comms-triage-0" 
                            onClick={handleDeploy}
                            disabled={isDeploying || (!audiences.families && !audiences.partners && !audiences.media)}
                            style={{ width: '100%', padding: '20px', backgroundColor: isDeploying ? '#991B1B' : '#DC2626', color: 'white', border: 'none', borderRadius: '8px', fontSize: '1.2rem', fontWeight: 900, textTransform: 'uppercase', cursor: (isDeploying || (!audiences.families && !audiences.partners && !audiences.media)) ? 'not-allowed' : 'pointer', display: 'flex', justifyContent: 'center', alignItems: 'center', gap: '12px', marginTop: '24px', transition: 'background-color 0.2s' }}
                        >
                            {isDeploying ? (
                                <span className="animate-pulse">TRANSMITTING SECURE PAYLOAD...</span>
                            ) : (
                                <><Send size={24} /> DEPLOY EMERGENCY BROADCAST</>
                            )}
                        </button>
                    ) : (
                        <div style={{ width: '100%', padding: '20px', backgroundColor: '#064E3B', color: '#34D399', border: '2px solid #10B981', borderRadius: '8px', fontSize: '1.2rem', fontWeight: 900, textTransform: 'uppercase', textAlign: 'center', marginTop: '24px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '12px' }}>
                            <ShieldAlert size={24} /> TRANSMISSION COMPLETE
                        </div>
                    )}
                </div>
            </div>
            
             <div style={{ marginTop: '32px', padding: '16px', backgroundColor: 'rgba(220, 38, 38, 0.1)', borderRadius: '8px', border: '1px dashed #DC2626', fontSize: '0.85rem', color: '#FCA5A5' }}>
                <strong>WARNING:</strong> Initiation of this protocol bypasses standard marketing review layers. Ensure the situation qualifies as a Tier 1 Emergency under the Corporate Operations Manual Section 4A before executing.
            </div>
        </div>
    );
};
